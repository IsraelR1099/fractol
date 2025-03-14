# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: irifarac <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/28 13:33:23 by irifarac          #+#    #+#              #
#    Updated: 2025/03/14 14:00:43 by irifarac         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#Colores
RED = \033[0;31m
GREEN = \033[0;32m
RESET = \033[0m

NAME := fractol
OS := $(shell uname)

#La opcion -MMD crea una dependencia hacia los headers del usuario
#La opcion -MD crea una dependencia hacia los headers del sistema y del usuario
CFLAGS := -Wall -Wextra -Werror -MMD -O3 -g
ifeq ($(OS), Linux)
	MLX = ./miniLibX_X11/
	MLX_LNK = -L$(MLX) -lmlx -lXext -lX11
else
	MLX = ./miniLibX/
	MLX_LNK = -L$(MLX) -lmlx -framework OpenGL -framework AppKit
endif
DEPS = include/lib_fractal.h
DEPS_MLX = $(MLX)/mlx.h
SRC = src/ft_formulas.c \
	  src/ft_formulas2.c \
	  src/ft_formulas3.c \
	  src/ft_generate.c \
	  src/ft_generate_more.c \
	  src/ft_handler.c \
	  src/ft_iteration.c \
	  src/ft_iteration2.c \
	  src/ft_options.c \
	  src/ft_utils.c \
	  src/ft_zoom.c \
	  src/main.c

MLX_INC = -I$(MLX)
MLX_LIB = $(addprefix $(MLX), mlx.a)

#Substituye todos los .c por .o pat subst es lo mismo pero de otra forma
OBJ = $(SRC:.c=.o)
DEPENDS = $(patsubst %.c, %.d, $(SRC))

all: $(MLX_LIB) $(NAME)

#incluir la dependencia a Makefile
-include $(OBJ:.o=.d)
%.o: %.c
	gcc $(CFLAGS) $(MLX_INC) -I./include -o $@ -c $<
	@echo "$(GREEN)Objetos creados.$(RESET)"

$(MLX_LIB):
	make -C $(MLX)

$(NAME): $(MLX_LIB) $(OBJ)
	@echo "$(GREEN)Compilando binario...$(RESET)"
	gcc $(OBJ) $(MLX_LNK) -lm -o $(NAME)
	@echo "$(GREEN)Compilacion acabada$(RESET)"

bonus: $(NAME)

clean:
	cd $(MLX) && make $@
	rm -f $(OBJ) $(DEPENDS)
	@echo "$(RED)Objetos borrados$(RESET)"

fclean: clean
	rm -f $(NAME)
	@echo "$(RED)Ejecutable borrado$(RESET)"

re: fclean all

.PHONY: all clean fclean re

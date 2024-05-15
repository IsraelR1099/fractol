# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: irifarac <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/28 13:33:23 by irifarac          #+#    #+#              #
#    Updated: 2024/05/15 09:59:11 by irifarac         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#Colores
RED = \033[0;31m
GREEN = \033[0;32m
RESET = \033[0m

NAME := fractol

#La opcion -MMD crea una dependencia hacia los headers del usuario
#La opcion -MD crea una dependencia hacia los headers del sistema y del usuario
CFLAGS := -Wall -Wextra -Werror -MMD -O3 -fsanitize=address -g
DEPS = include/lib_fractal.h
DEPS_MLX = mlx/mlx.h
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

#Substituye todos los .c por .o pat subst es lo mismo pero de otra forma
OBJ = $(SRC:.c=.o)
DEPENDS = $(patsubst %.c, %.d, $(SRC))

all: $(NAME)

$(NAME): $(OBJ)
	@echo "$(GREEN)Compilando libreria mlx$(RESET)"
	cd mlx && make all
	gcc $(CFLAGS) $(SRC) -Lmlx -lmlx -framework OpenGL -framework AppKit -o $@
	rm -f fractol.d
	@echo "$(GREEN)Compilacion acabada$(RESET)"

#incluir la dependencia a Makefile
-include $(OBJ:.o=.d)
%.o: %.c
	gcc $(CFLAGS) -o $@ -c $<

bonus: $(NAME)

clean:
	cd mlx && make $@
	rm -f $(OBJ) $(DEPENDS)
	@echo "$(RED)Objetos borrados$(RESET)"

fclean: clean
	rm -f $(NAME)
	@echo "$(RED)Ejecutable borrado$(RESET)"

re: fclean all

.PHONY: all clean fclean re

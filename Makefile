LIBRARY = libasm.a
PROGRAM = program

PURPLE = \033[1;95m
RESET = \033[0m

SRC_DIR = sources
INC_DIR = includes
OBJ_DIR = objects

FILES = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
BONUS_FILES = ft_atoi_base_bonus.s
TEST_FILE = main.c

SRC = $(addprefix $(SRC_DIR)/, $(FILES))
BONUS_SRC = $(addprefix $(SRC_DIR)/, $(BONUS_FILES))

OBJ = $(addprefix $(OBJ_DIR)/, $(FILES:.s=.o))
BONUS_OBJ = $(addprefix $(OBJ_DIR)/, $(BONUS_FILES:.s=.o))

AFLAGS = -f elf64 -o
CFLAGS = -Wall -Werror -Wextra
DEBUG_FLAGS = -g -F dwarf

$(LIBRARY): $(OBJ_DIR) $(OBJ)
	ar rcs $(LIBRARY) $(OBJ)
	@printf "$(PURPLE)-----------------Created an Assembly library------------------$(RESET)\n"
	
$(PROGRAM): $(LIBRARY) $(TEST_FILE)
	gcc $(CFLAGS) -o program $(TEST_FILE) $(LIBRARY)
	@printf "$(PURPLE)----------Compiled main.c and linked it with library----------$(RESET)\n"


$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	nasm $(AFLAGS) $@ $< $(DEBUG_FLAGS)
#nasm $(AFLAGS) $@ $<

all: $(LIBRARY) $(PROGRAM)
bonus: $(BONUS_OBJ) $(LIBRARY)
	ar rcs $(LIBRARY) $(BONUS_OBJ)
	@printf "$(PURPLE)-----------------Added bonus files to Assembly library------------------$(RESET)\n"
	$(MAKE) $(PROGRAM)

clean:
	rm -rf $(OBJ_DIR)
fclean: clean
	rm -f $(LIBRARY)
	rm $(PROGRAM)

re: fclean all

.PHONY: all bonus clean fclean re
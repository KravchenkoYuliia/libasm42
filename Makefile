LIBRARY = libasm.a
PROGRAM = program

all: $(LIBRARY) $(PROGRAM)

PURPLE = \033[1;95m
RESET = \033[0m

SRC_DIR = sources
INC_DIR = includes
OBJ_DIR = objects

FILES = ft_strlen.s ft_strcpy.s
TEST_FILE = main.c

SRC = $(addprefix $(SRC_DIR)/, $(FILES))
OBJ = $(addprefix $(OBJ_DIR)/, $(FILES:.s=.o))

AFLAGS = -f elf64 -o
CFLAGS = -Wall -Werror -Wextra
DEBUG_FLAGS = -g -F dwarf

$(LIBRARY): $(OBJ_DIR) $(OBJ)
	ar rcs $(LIBRARY) $(OBJ)
	@printf "$(PURPLE)-----------------Created an Assembly library------------------$(RESET)\n"
	
$(PROGRAM): $(LIBRARY) $(TEST_FILE)
	cc $(CFLAGS) -o program $(TEST_FILE) $(LIBRARY)
	@printf "$(PURPLE)----------Compiled main.c and linked it with library----------$(RESET)\n"


$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
#nasm $(AFLAGS) $@ $< $(DEBUG_FLAGS)
	nasm $(AFLAGS) $@ $<

clean:
	rm -rf $(OBJ_DIR)
fclean: clean
	rm -f $(LIBRARY)
	rm $(PROGRAM)

re: fclean all
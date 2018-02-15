#
# Copyright (c) 2013 Pavlo Lavrenenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

CC	=gcc -march=native -std=gnu99
CFLAGS	=-O3 -fPIC -Wall -pedantic -pipe
CFLAGS	+= `pkg-config --cflags pidgin`

LDFLAGS	=-shared

LDLIBS	=`pkg-config --libs pidgin`

PREFIX := /usr/local
LIBDIR := ${PREFIX}/lib64

SOURCES := ${wildcard *.c}
OBJECTS := ${patsubst %.c, %.o, ${SOURCES}}

all:: usercast.so

usercast.so:: ${OBJECTS} usercast.h
	${CC} -o $@ ${CFLAGS} ${LDFLAGS} ${LDLIBS} $^

install:: usercast.so
	install $^ ${DESTDIR}${LIBDIR}/pidgin/$^

clean::
	${RM} *.o a.out core*

clobber distclean:: clean
	${RM} usercast.so

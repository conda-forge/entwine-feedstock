#!/bin/bash

set -ex
if [ "$(uname)" == "Linux" ]
then
   export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi


mkdir build
cd build
cmake -G "Ninja" \
      ${CMAKE_ARGS} \
      -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
      -DCMAKE_BUILD_TYPE:STRING=Release \
      -DCMAKE_LIBRARY_PATH="${PREFIX}/lib" \
      -DCMAKE_INCLUDE_PATH="${PREFIX}/include" \
      -DWITH_TESTS=OFF \
      -DWITH_ZSTD=OFF \
      ..

# CircleCI offers two cores.
ninja
ninja install

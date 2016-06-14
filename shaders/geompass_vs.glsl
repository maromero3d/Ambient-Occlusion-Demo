/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Gabriel de Quadros Ligneul
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 *all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#version 450

// Matrices information
struct Matrices {
  mat4 mvp;
  mat4 modelview;
  mat4 normalmatrix;
};

layout(std140) uniform MatricesBlock { Matrices matrices[100]; };

// Mesh input
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 normal;

// Vertex output
out vec3 frag_position;
out vec3 frag_normal;
out vec2 frag_textcoord;

void main() {
  Matrices M = matrices[gl_InstanceID];
  gl_Position = M.mvp * position;
  frag_position = vec3(M.modelview * position);
  frag_normal = normalize(vec3(M.normalmatrix * normal));
}


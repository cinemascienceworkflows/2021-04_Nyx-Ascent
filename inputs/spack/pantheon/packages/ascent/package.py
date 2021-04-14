# Copyright 2013-2020 Lawrence Livermore National Security, LLC and other
# Spack Project Developers. See the top-level COPYRIGHT file for details.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)

from spack import *
from spack.pkg.builtin.ascent import Ascent

class Ascent(Ascent):
    version('0.6.0', sha256='eb428f665862a729b3279b1ffb67ae71f2d29ceb1bb83672cd504fed9167df64')

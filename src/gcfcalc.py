'''
 Copyright (C) 2021-2022 Piotr Lange

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 GCF&LCM is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
'''

def calcgcf(numberlist):
	try:
		nums = numberlist.split(".")
		finalgcf = 0
		for iii in range(len(nums)):
			nnn = nums[iii]
			nnn = int(nnn.strip())
			if iii == 0:
				finalgcf = nnn
			else:
				finalgcf = gcf(finalgcf, nnn)
		return True, finalgcf
	except:
		return False, 0

def gcf(aaa, bbb):
	while bbb:
		aaa, bbb = bbb, aaa % bbb
	return aaa

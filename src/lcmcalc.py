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

def calclcm(numberlist):
	try:
		nums = numberlist.split(".")
		finallcm = 0
		for iii in range(len(nums)):
			nnn = nums[iii]
			nnn = int(nnn.strip())
			if iii == 0:
				finallcm = nnn
			else:
				finallcm = lcm(finallcm, nnn)
		return True, finallcm
	except:
		return False, 0

def gcf(aaa, bbb):
	while bbb:
		aaa, bbb = bbb, aaa % bbb
	return aaa

def lcm(aaa, bbb):
	if aaa == 0 or bbb == 0:
		return 0
	return int(aaa * bbb / gcf(aaa, bbb))     

'''
	******************************************************************************************
	  Assembly:                Armory
	  Filename:                config.py
	  Author:                  Terry D. Eppler
	  Created:                 05-31-2022
	
	  Last Modified By:        Terry D. Eppler
	  Last Modified On:        05-01-2025
	******************************************************************************************
	<copyright file="config.py" company="Terry D. Eppler">
	
		     Armory.py
		     Copyright ©  2022  Terry Eppler
	
	     Permission is hereby granted, free of charge, to any person obtaining a copy
	     of this software and associated documentation files (the “Software”),
	     to deal in the Software without restriction,
	     including without limitation the rights to use,
	     copy, modify, merge, publish, distribute, sublicense,
	     and/or sell copies of the Software,
	     and to permit persons to whom the Software is furnished to do so,
	     subject to the following conditions:
	
	     The above copyright notice and this permission notice shall be included in all
	     copies or substantial portions of the Software.
	
	     THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	     INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	     FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
	     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
	     DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
	     ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
	     DEALINGS IN THE SOFTWARE.
	
	     You can contact me at:  terryeppler@gmail.com or eppler.terry@epa.gov
	
	</copyright>
	<summary>
	 config.py
	</summary>
	******************************************************************************************
'''
import os

# LARGE LANGUAGE MODELS URLS

BOBO_LLM = r'https://huggingface.co/leeroy-jankins/bobo'
BOOGR_LLM = r'https://huggingface.co/leeroy-jankins/boogr'
NOMNOM_LLM = r'https://huggingface.co/leeroy-jankins/nomi'
BUBBA_LLM = r'https://huggingface.co/leeroy-jankins/bubba'
JIMI_LLM = r'https://huggingface.co/leeroy-jankins/jimi'
LEEROY_LLM = r'https://huggingface.co/leeroy-jankins/leeroy'
BOO_LLM = r'https://huggingface.co/leeroy-jankins/boo'
BUDDY_LLM = r"https://huggingface.co/leeroy-jankins/buddy"
GIPITY_LLM = r'https://huggingface.co/leeroy-jankins/gipity'
BRO_LLM = r'https://huggingface.co/leeroy-jankins/bro'


# MACHINE LEARNING URLS

POGI_PY = r'https://pogi-py.streamlit.app/'
SAKE_PY = r'https://sake-py.streamlit.app/'
SCHEDULEX = r'https://schedule-x.streamlit.app/'
CUTEY_PY = r'https://cutey-py.streamlit.app/'
MATHY_PY = r'https://mathy-py.streamlit.app/'
CHONKY_PY = r'https://chonky-py.streamlit.app/'
SIGE_PY = r'https://sige-py.streamlit.app/'
MAPPY_PY = r'https://mappy-py.streamlit.app/'
FOO_PY = r'https://fooo-py.streamlit.app/'


# GENERATIVE AI URLS
GURO = r''
BOO_PY = r'https://boo-py.streamlit.app/'
GIPITY_PY = r'https://gipity-py.streamlit.app/'
JENI_PY = r'https://jeni-py.streamlit.app/'
JIMI_PY = r'https://jimi-py.streamlit.app/'
BUDDY_PY = r'https://buddy-py.streamlit.app/'
LEEROY_PY = r'https://leeroy.streamlit.app/'


SECRET_KEY = os.urandom( 32 )

def set_environment( ):
	"""

		Purpose:
		--------
		Gets availible environment vaariables for configuration


	"""
	variable_dict = globals( ).items( )
	for key, value in variable_dict:
		if 'API' in key or 'ID' in key:
			os.environ[ key ] = value


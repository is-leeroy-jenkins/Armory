/**************************************************************************************************
 *     File Name:               main.js
 *     Assembly:                Armory
 *     Author:                  Terry D. Eppler
 *     Created:                 03-24-2023
 *
 *     Last Modified By:        Terry D. Eppler
 *     Last Modified On:        05-31-2024
 *
 * <copyright file="main.js" company="Terry Eppler">
 *    Armory is a Flask application for Data Analytics Integration & Analysis
 *
 *    Copyright ©  2024  Terry Eppler
 *
 *    Permission is hereby granted, free of charge, to any person obtaining a copy
 *    of this software and associated documentation files (the “Software”),
 *    to deal in the Software without restriction,
 *    including without limitation the rights to use,
 *    copy, modify, merge, publish, distribute, sublicense,
 *    and/or sell copies of the Software,
 *    and to permit persons to whom the Software is furnished to do so,
 *    subject to the following conditions:
 *
 *    The above copyright notice and this permission notice shall be included in all
 *    copies or substantial portions of the Software.
 *
 *    THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 *    INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *    FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
 *    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 *    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 *    ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *    DEALINGS IN THE SOFTWARE.
 *
 *    You can contact me at: terryeppler@gmail.com or eppler.terry@epa.gov
 * </copyright>
 * <summary>
 *   main.js
 * </summary>
 **************************************************************************************************/


// Initialize AOS animations
AOS.init( {
	duration: 1000,
	once: true,
} );

// Dark Mode Toggle Logic with persistence
const toggle = document.getElementById( 'darkModeToggle' );
const body = document.getElementById( 'body' );

// Load saved theme from localStorage
const savedTheme = localStorage.getItem( 'theme' );
if( savedTheme === 'dark' )
{
	body.classList.add( 'dark-mode' );
	toggle.checked = true;
}
else
{
	body.classList.remove( 'dark-mode' );
	toggle.checked = false;
}

// Listen for toggle changes
toggle.addEventListener( 'change', () =>
{
	if( toggle.checked )
	{
		body.classList.add( 'dark-mode' );
		localStorage.setItem( 'theme', 'dark' );
	}
	else
	{
		body.classList.remove( 'dark-mode' );
		localStorage.setItem( 'theme', 'light' );
	}
} );

// Typed.js animation for hero subtext
const roles = [ 'Machine & Deep Learning', 'Data Analysis', 'Data Visualization',
	'Predictive Analytics', 'AI Integration' ];

let typedIndex = 0;
let charIndex = 0;
let isDeleting = false;
const typedText = document.getElementById( 'typed-text' );
const typingSpeed = 100;
const deletingSpeed = 50;
const delayBetween = 2000;

function type()
{
	const currentRole = roles[ typedIndex ];
	if( isDeleting )
	{
		charIndex--;
		typedText.textContent = currentRole.substring( 0, charIndex );
		if( charIndex === 0 )
		{
			isDeleting = false;
			typedIndex = ( typedIndex + 1 ) % roles.length;
			setTimeout( type, 1 );
		}
		else
		{
			setTimeout( type, deletingSpeed );
		}
	}
	else
	{
		charIndex++;
		typedText.textContent = currentRole.substring( 0, charIndex );
		if( charIndex === currentRole.length )
		{
			isDeleting = true;
			setTimeout( type, delayBetween );
		}
		else
		{
			setTimeout( type, typingSpeed );
		}
	}
}

// Start typing effect if element present
if( typedText )
{
	type();
}

// Project Filtering
const filterButtons = document.querySelectorAll( '.filter-btn' );
const projectCards = document.querySelectorAll( '.project-card' );

// Filter button click
filterButtons.forEach( btn =>
{
	btn.addEventListener( 'click', function()
	{
		filterButtons.forEach( b => b.classList.remove( 'active' ) );
		this.classList.add( 'active' );
		const filter = this.getAttribute( 'data-filter' );
		projectCards.forEach( card =>
		{
			if( filter === 'all' || card.getAttribute( 'data-category' ).includes( filter ) )
			{
				card.style.display = '';
			}
			else
			{
				card.style.display = 'none';
			}
		} );
	} );
} );

// Project card click: open GitHub (update data-link attribute as you add projects)
document.querySelectorAll( '.project-card' ).forEach( card =>
{
	card.addEventListener( 'click', function()
	{
		const link = this.getAttribute( 'data-link' );
		if( link )
		{
			window.open( link, '_blank' );
		}
	} );
} );

// Education & Certification Tabs
const eduTabBtn = document.getElementById( 'eduTab' );
const certTabBtn = document.getElementById( 'certTab' );
const eduContent = document.getElementById( 'educationContent' );
const certContent = document.getElementById( 'certificationsContent' );
if( eduTabBtn && certTabBtn && eduContent && certContent )
{
	eduTabBtn.addEventListener( 'click', () =>
	{
		eduTabBtn.classList.add( 'active' );
		certTabBtn.classList.remove( 'active' );
		eduContent.classList.remove( 'd-none' );
		certContent.classList.add( 'd-none' );
	} );
	certTabBtn.addEventListener( 'click', () =>
	{
		certTabBtn.classList.add( 'active' );
		eduTabBtn.classList.remove( 'active' );
		certContent.classList.remove( 'd-none' );
		eduContent.classList.add( 'd-none' );
	} );
}

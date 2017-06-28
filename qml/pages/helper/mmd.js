/*
MIT License

Copyright (c) 2012 Mathieu 'p01' Henri

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

;function mmd(src)
{
	var h='';

    function escape(t)
    {
        return t;
    }
	function inlineEscape(s)
	{
        return escape(s)
			.replace(/!\[([^\]]*)]\(([^(]+)\)/g, '<img alt="$1" src="$2">')
            .replace(/\[([^\]]+)]\(([^(]+)\)/g, '<a href="$2">$1</a>')
			.replace(/`([^`]+)`/g, '<code>$1</code>')
			.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
			.replace(/\*([^*]+)\*/g, '<em>$1</em>');
	}

	src
	.replace(/^\s+|\r|\s+$/g, '')
	.replace(/\t/g, '    ')
	.split(/\n\n+/)
	.forEach(function(b, f, R)
	{
		f=b[0];
		R=
		{
			'*':[/\n\* /,'<ul><li>','</li></ul>'],
			'1':[/\n[1-9]\d*\.? /,'<ol><li>','</li></ol>'],
			' ':[/\n    /,'<pre><code>','</pre></code>','\n'],
			'>':[/\n> /,'<blockquote>','</blockquote>','\n']
		}[f];
		h+=
			R?R[1]+('\n'+b)
				.split(R[0])
				.slice(1)
                .map(R[3]?inlineEscape:inlineEscape)
				.join(R[3]||'</li>\n<li>')+R[2]:
			f=='#'?'<h'+(f=b.indexOf(' '))+'>'+inlineEscape(b.slice(f+1))+'</h'+f+'>':
			f=='<'?b:
			'<p>'+inlineEscape(b)+'</p>';
	});
	return h;
};

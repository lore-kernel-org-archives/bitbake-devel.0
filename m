Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1Txkdk-0007wX-95
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 21:40:39 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r0MKOj5E008484
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2013 12:24:45 -0800 (PST)
Received: from e6410-2 (172.25.40.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Tue, 22 Jan 2013 12:24:45 -0800
Date: Tue, 22 Jan 2013 14:24:30 -0600
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <20130122142430.1cc1a705@e6410-2>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Subject: Half-baked proposal: Introduce @{foo} variable expansion for bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 22 Jan 2013 20:41:09 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Observed issues:
1. It can be non-obvious to a user that ${foo} in a shell script is
probably expanded by bitbake, unless foo isn't set, but that
${foo#pattern} is expanded by the shell, and so on.
2. Furthermore, because ${foo#pattern} wants to be expanded by the
shell, we can't easily add functionality similar to some of the shell
expansion rules.
3. For instance, think how useful it would be to have an easy way to
express the equivalent of a shell ${foo:+/$foo} or ${foo:+:$foo}
without an elaborate hunk of Python in a ${@...}.

My suggestion:
Right now, I don't see a single @{ anywhere in oe-core. I propose the
introduction of @{foo} as variable-expansion syntax, with intent that
it would acquire the functionality of POSIX shell expansions, at least
as far as:
	@{foo-bar} => bar if foo is unset, else foo
	@{foo+bar} => bar if foo is set
	@{foo:-bar} => -bar, but "empty or unset"
	@{foo:+bar} => +bar, but "empty or unset"
	@{foo#bar} => foo with a minimal leading bar removed
	@{foo##bar} => foo with a maximal leading bar removed
	@{foo%bar} => like #, but trailing pattern
	@{foo%%bar} => like ##, but trailing pattern

And maybe a couple of others:
	@{foo<bar} => foo, with bar as a prefix if foo is set
	@{foo>bar} => foo, with bar as a suffix if foo is set
	@{foo?bar:baz} => bar if foo is set, baz otherwise.

There is a lot of work right now going into replicating these
functionalities. For instance, consider the prefix BBEXTENDVARIANT,
which might be "lib32". I have a name, ${FOO}. I want to express a
value which is:
	${BBEXTENDVARIANT}-${FOO}
if BBEXTENDVARIANT is set-and-non-empty, or
	${FOO}
otherwise.

No problem! I just write:
PREFIX = "${@['', (d.getVar("BBEXTENDVARIANT", True) or "") +
'-'][(d.getVar("BBEXTENDVARIANT", True) or "") != ""]}"

and then use ${PREFIX}${FOO}.

... wait, that's horrible. What if I could write:
	@{BBEXTENDVARIANT+@{BBEXTENDVARIANT}-}
instead? That's practically legible by comparison. Or, with the new
bonus features,
	@{BBEXTENDVARIANT>-}

Yes, I'm sort of volunteering to try to add this functionality in my
Copious Free Time. My thought is that this would be phased:

1. Add the new syntax.
2. Encourage people to use the new syntax.
3. Gradually start discouraging the old syntax.
4. Eventually replace it completely.

Benefits: Much clearer code, a lot fewer inline Python hacks, less
ambiguity about shell variable expansion, and every time you approve of
one of my crazy ideas, a pony gets a lovely apple, crisp and sweet.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.



Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TvXRT-0001SR-Bi for bitbake-devel@lists.openembedded.org;
	Wed, 16 Jan 2013 19:10:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0GHt5LZ026177;
	Wed, 16 Jan 2013 17:55:05 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23524-05; Wed, 16 Jan 2013 17:55:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0GHsxCS026162
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2013 17:55:00 GMT
Message-ID: <1358358898.24249.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Wed, 16 Jan 2013 17:54:58 +0000
In-Reply-To: <cover.1357954043.git.peter.seebach@windriver.com>
References: <cover.1357954043.git.peter.seebach@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Variable tracking: Cleaned up and rebased.
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
X-List-Received-Date: Wed, 16 Jan 2013 18:10:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-01-11 at 19:40 -0600, Peter Seebach wrote:
> This is the much-famed "variable tracking" patch. Rebased against current
> bitbake, fixed a couple of things.
> 
> WHAT IT DOES:
> 
>         $ bitbake -e > variable_history
> 
>         $ cat variable_history
>         #
>         # INCLUDE HISTORY:
>         #
>         # /home/seebs/oe-core/build/conf/bblayers.conf
>         # /home/seebs/oe-core/meta/conf/layer.conf
>         # conf/bitbake.conf includes:
>         #   /home/seebs/oe-core/meta/conf/abi_version.conf
>         #   conf/site.conf
>         #   conf/auto.conf
>         #   /home/seebs/oe-core/build/conf/local.conf
>         [...]
>         # $prefix [2 operations]
>         #   exported conf/bitbake.conf:17
>         #     [export] "1"
>         #   set conf/bitbake.conf:17
>         #     "/usr"
>         # computed:
>         #   "/usr"
>         export prefix="/usr"
>         [...]
> 
> This can get pretty useful if you're trying to find out, say, where
> the -m32 came from in TUNE_CCARGS:
> 
>         # $TUNE_CCARGS [6 operations]
>         #   set conf/bitbake.conf:105
>         #     [defaultval] ""
>         #   set conf/bitbake.conf:106
>         #     [vardepvalue] "${TUNE_CCARGS}"
>         #   append /home/seebs/oe-core/meta/conf/machine/include/ia32/arch-ia32.inc:16
>         #     "${@bb.utils.contains("TUNE_FEATURES", "m32", "-m32", "", d)}"
>         #   append /home/seebs/oe-core/meta/conf/machine/include/ia32/arch-ia32.inc:24
>         #     "${@bb.utils.contains("TUNE_FEATURES", "mx32", "-mx32", "", d)}"
>         #   append /home/seebs/oe-core/meta/conf/machine/include/ia32/arch-ia32.inc:32
>         #     "${@bb.utils.contains("TUNE_FEATURES", "m64", "-m64", "", d)}"
>         #   append /home/seebs/oe-core/meta/conf/machine/include/tune-i586.inc:7
>         #     "${@bb.utils.contains("TUNE_FEATURES", "i586", "-march=i586", "", d)}"
>         # computed:
>         #   " ${@bb.utils.contains("TUNE_FEATURES", "m32", "-m32", "", d)} ${@bb.utils.contains("TUNE_FEATURES", "mx32", "-mx32", "", d)} ${@bb.utils.contains("TUNE_FEATURES", "m64", "-m64", "", d)} ${@bb.utils.contains("TUNE_FEATURES", "i586", "-march=i586", "", d)}"
>         TUNE_CCARGS="-m32   -march=i586"
>         #
> 
> The cleanup since the last version is pretty minor, but there was one real
> bug: If any part of a variable's history showed a modification from Python
> code (with a function name) rather than from the parser, the variable's
> value would be displayed as though it were a function. Whoops.
> 
> The output for renames is now much more useful than it was before, though:
> 
> # $SECTION_${PN}-dbg [2 operations]
> #   set conf/bitbake.conf:316
> #     "devel"
> #   rename (to) data.py:161 [expandKeys]
> #     "SECTION_core-image-minimal-dbg"
> # computed:
> #   "None"
> 
> and
> 
> # $SECTION_core-image-minimal-dbg
> #   rename from SECTION_${PN}-dbg data.py:161 [expandKeys]
> #     "devel"
> SECTION_core-image-minimal-dbg="devel"
> 
> I remain a little unhappy with the loginfo stuff, in particular the
> possible clash between keys in loginfo and non-keyword arguments, but
> I can't really think of a way to make it definitely better, and the
> much-less-intrusive usage strikes me as a big enough improvement to
> justify it. (Picking different names for the keyword arguments would
> reduce clashes, and also legibility in cases where they're being
> specified.)
> 
> The following changes since commit dee7decf87dfa8cb966fe40846d27f3e6ab1846b:
>   Richard Purdie (1):
>         build.py: Fix traceback when there are no dependencies
> 
> are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib seebs/incvar
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/incvar
> 
> Peter Seebach (2):
>   data_smart.py and friends: Track file inclusions for bitbake -e
>   data_smart.py and friends: Track variable history

I *really* want to take these, however I did want to check performance:

Before:

$ time bitbake core-image-sato -e
real	0m8.034s
$ time bitbake -p
real	0m12.220s
user	3m3.887s

After:

$ time bitbake core-image-sato -e
real	0m50.267s
$ time bitbake -p
real	0m14.607s
user	3m55.179s


The 50s seems a touch excessive and it looks like a 20% parsing hit even
when unused :(. Note the overall parsing times on this machine are fast
as its running 24 in parallel. I'm going to try and figure out what is
going on tomorrow as I've fixed a lot of this kind of thing in the past
but wanted to mention it...

Cheers,

Richard














Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1S9bUe-0006et-U6
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 13:15:21 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1S9bM7-0002XF-BK for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 08:06:31 -0400
Date: Mon, 19 Mar 2012 08:06:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1203190752550.23022@oneiric>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: first observations about current bitbake manual
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
X-List-Received-Date: Mon, 19 Mar 2012 12:15:21 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  in ch 2, the explanation about different types of assignment seems
to be deficient.  there's a definition of what is a "weak" default
value, but this isn't contrasted with what is commonly referred to as
"hard" assignment.  i think that needs to be explained, especially
since i've seen recipe files that explicitly discuss why weak
assignment won't work and "hard" assignment must be used, but the poor
reader will probably not understand what's going on. frankly, i think
that whole section on the varieties of assignment could be cleaned up.

  next, i don't see any mention of useful utilities like
bitbake-layers.  are those meant to be used by the normal OE user?  if
so, they really should be mentioned and their use demonstrated.

  finally (at least for now), it would be more informative if generic
examples using things like "foo" were replaced by actual snippets from
oe-core.  consider the explanations of conditional metadata, with
examples like:

OVERRIDES = "foo"
A = "X"
A_append_foo = "Y"

but that doesn't help the new user much since it totally lacks any
meaningful context.  a simple grep shows:

$ grep -r "append_arm" *
meta/recipes-multimedia/libmad/libmad_0.15.1b.bb:EXTRA_OECONF_append_arm = " --enable-fpm=arm"
meta/recipes-devtools/python/python_2.7.2.bb:TARGET_CC_ARCH_append_armv6 = " -D__SOFTFP__"
meta/recipes-devtools/python/python_2.7.2.bb:TARGET_CC_ARCH_append_armv7a = " -D__SOFTFP__"
meta/recipes-core/initscripts/initscripts_1.0.bb:SRC_URI_append_arm = " file://alignment.sh"
meta/recipes-qt/qt4/qt4-embedded_4.7.4.bb:QT_CONFIG_FLAGS_append_armv6 = " -no-neon "
meta/recipes-qt/qt4/qt4-x11-free_4.8.0.bb:QT_CONFIG_FLAGS_append_armv6 = " -no-neon "
meta/recipes-qt/qt4/qt4-embedded_4.8.0.bb:QT_CONFIG_FLAGS_append_armv6 = " -no-neon "
meta/recipes-qt/qt4/qt4-x11-free_4.7.4.bb:QT_CONFIG_FLAGS_append_armv6 = " -no-neon "
... snip ...
$

  now *that's* useful -- it's *immediately* obvious what's going on in
the above.  and throwing in another example for contrast:

$ grep -r "append_mips" *
meta/recipes-kernel/sysprof/sysprof_git.bb:SRC_URI_append_mips = " file://rmb-mips.patch"
meta/recipes-extended/libzypp/libzypp_git.bb:SRC_URI_append_mips = " file://mips-workaround-gcc-tribool-error.patch"
$

  in short, don't use generic examples when actual ones exist.  more
later.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================



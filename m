Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TirjJ-0004qs-2o
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 20:12:30 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([174.115.5.73]:44952 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1TirVE-0008Qc-8u; Wed, 12 Dec 2012 13:57:56 -0500
Date: Wed, 12 Dec 2012 13:57:53 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: =?ISO-8859-15?Q?Eren_T=FCrkay?= <eren@hambedded.org>
In-Reply-To: <20121212184156.GA743@gmail.com>
Message-ID: <alpine.DEB.2.02.1212121356150.13192@oneiric>
References: <20121212184156.GA743@gmail.com>
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
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 19:12:30 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-283571410-1355338675=:13192"

--8323329-283571410-1355338675=:13192
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 12 Dec 2012, Eren Türkay wrote:

> Currently, *.bb and *.bbclass files are automatically highlighted and
> detected as a bitbake file. Since *.bbappend files are also bitbake
> files, vim plugin should automatically detect and highlight it as well.
> ---
>  contrib/vim/ftdetect/bitbake.vim |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbake.vim
> index 179e4d9..6822e24 100644
> --- a/contrib/vim/ftdetect/bitbake.vim
> +++ b/contrib/vim/ftdetect/bitbake.vim
> @@ -11,7 +11,7 @@ if &compatible || version < 600
>  endif
>
>  " .bb and .bbclass
> -au BufNewFile,BufRead *.b{b,bclass}	set filetype=bitbake
> +au BufNewFile,BufRead *.b{b,bappend,bclass}	set filetype=bitbake

  gack.  there's no compelling reason to be that, um, pedantic with
the wildcard pattern.  just use

  *.{bb,bbappend,bbclass}

trying to save a couple characters while introducing that kind of
visual ugliness just isn't worth it.


rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323329-283571410-1355338675=:13192--

Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
	by mail.openembedded.org (Postfix) with ESMTP id D37386E8B1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Feb 2014 22:11:23 +0000 (UTC)
Received: by mail-ee0-f50.google.com with SMTP id d17so3885443eek.23
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Feb 2014 14:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=1k6yiFIR44w/Q1KQ6O1zw6UOb9EUKzilWB7mex/UPvc=;
	b=O+wjkBQ5253tjt0CAoRlHvF8o/4iMtCPQioQUStPsMA721xkw8VmAyFbXvuL+Py7/h
	SuzD2M5jvLufcdRa5w/8KwnzZ8McWrSiVr4Cibhhugx1aOl37eTuZfd6sHWipmwuN/YT
	5jlCX8HeBa3e/hMZvniuImebxfZqDcHA5SYlzxCiAkjcCGfm4O2GtjpmtfTkLLnFAPmw
	/NUVgylspkOkfCglIR1fAx3q74EfNOe0uRyP4HGICefUgISLVf2JJgjsBS9W+X1vWtwG
	QZMzVVAkRfvjgPKsz868rOnD/9QcjXGZzNdYupKb9WPOlM2q+AWAGCqKFavZ9T69A3d7
	mfkg==
X-Received: by 10.15.22.65 with SMTP id e41mr25791062eeu.5.1391465484333;
	Mon, 03 Feb 2014 14:11:24 -0800 (PST)
Received: from nbbrfq.cc.univie.ac.at
	(91-119-228-86.dynamic.xdsl-line.inode.at. [91.119.228.86])
	by mx.google.com with ESMTPSA id m1sm80218671een.7.2014.02.03.14.11.22
	for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Mon, 03 Feb 2014 14:11:23 -0800 (PST)
Date: Mon, 3 Feb 2014 23:11:20 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140203221120.GA13798@nbbrfq.cc.univie.ac.at>
References: <1390231273.874.36.camel@ted>
 <1390250850.874.43.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1390250850.874.43.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] fetch2/git: Dereference unresolved names with ls-remote
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 03 Feb 2014 22:11:26 -0000
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 20, 2014 at 08:47:30PM +0000, Richard Purdie wrote:
> We need to deference tags when trying to map them to commit IDs with
> ls-remote. If we don't do this, a given commit might not show up
> later in a specific branch. There appears to be no good reason not
> to do this.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> 
> v2: Only apply ^{} to tags, not heads
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index d73f0cb..f7c26b3 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -326,7 +326,7 @@ class Git(FetchMethod):
>          else:
>              username = ""
>  
> -        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s" % \
> +        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s^{}" % \
>                (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name], ud.unresolvedrev[name])
>          if ud.proto.lower() != 'file':
>              bb.fetch2.check_network_access(d, cmd)

Hi Richard,

This and the previous df2e0972cd1db7abd5ec8b7cb295fb0c42e284a4 are very
inconvenient for my workflow (¹).
I usually have the toolchain locally for hacking, so my gcc,
binutils-gdb, uClibc and selected apps etc look like e.g.:

$ egrep "SRC(REV|PV|_URI )" meta/recipes-devtools/gcc/gcc-4.9.inc
SRCREV = "HEAD"
PV = "4.9.0+git${SRCPV}"
SRC_URI = "git:///scratch/src/gcc-4.9.mine/;branch=fixups-rtl;protocol=file;rebaseable=1"

This worked fine until your abovementioned changes. Can you advise how
my SRC_URI should look like so i am able to keep developing and
test changes now with the lot of oe-core and meta-openembedded as
checks?

thanks,

To reproduce:
$ git init /tmp/yuck
Initialized empty Git repository in /tmp/yuck/.git/
$ cd !$
$ echo | tee a > b
$ git add a
$ git commit -q -m '1c' a
$ git ls-remote file:///tmp/yuck/ HEAD
7532c4dab272c062c117b731e97889122dc10e67	HEAD
$ git ls-remote file:///tmp/yuck/ refs/heads/HEAD refs/tags/HEAD^{}
$

¹) think http://xkcd.com/1172/ but IMHO a tad less obscure since i'm
affected ;)


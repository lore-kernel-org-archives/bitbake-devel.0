Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 133DE71AE8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 10:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JAL5OV000350; Thu, 19 Jan 2017 10:21:05 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SLWjM3jtXFYa; Thu, 19 Jan 2017 10:21:05 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JAL2JZ000347
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Jan 2017 10:21:04 GMT
Message-ID: <1484821262.4367.424.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, Mark Hatle
	<mark.hatle@windriver.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 19 Jan 2017 10:21:02 +0000
In-Reply-To: <a8d463a0-f40a-afaf-c326-1f3bdffd49b7@windriver.com>
References: <f8610648-ea83-06ab-01fa-f8260597973c@windriver.com>
	<a8d463a0-f40a-afaf-c326-1f3bdffd49b7@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: Filename too long
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
X-List-Received-Date: Thu, 19 Jan 2017 10:21:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-01-19 at 14:13 +0800, Robert Yang wrote:
> Hi Mark,
> 
> We have a local patch to fix the problem, I had sent it to bitbake-
> devel
> before, but not merged:
> 
> https://patchwork.openembedded.org/patch/61321/
> 
> Here is the updated patch in our bitbake:
> 
> commit ebb1190c01a15fc6e91c9810c46313c3b3fb305c
> Author: Robert Yang <liezhi.yang@windriver.com>
> Date:   Fri Nov 8 23:32:11 2013 +0800
> 
>      fetch2/git.py: fix the filename too long error
> 
>      When we use the PREMIRROR/MIRROR from the local disk, and if it
> is in a
>      deep directory, for example, when len(path) > 255 (The
> NAME_MAX), we
>      will get the "filename too long error".
> 
>      This is becuase we use ud.path.replace('/', '.') to change the
> path to
>      the filename. We seldom see such a long url, but it is easy to
> produce
>      it on the local machine.
> 
>      Another problem is that:
> 
>      file:///local/path
> 
>      will be converted into .local.path which is a hidden file by
> default.

Looking at the code in your patch, this second piece clearly isn't true
due to this code:

          if gitsrcname.startswith('.'):
              gitsrcname = gitsrcname[1:]

I also don't believe this patch is correct since we're meant to be
creating a filename, not a path and if you leave the '/' characters in,
it isn't a filename. I think we likely just need to truncate the path
to the last say 225 chars if its over length. The unique piece should
be towards the right hand end of the name.

Cheers,

Richard


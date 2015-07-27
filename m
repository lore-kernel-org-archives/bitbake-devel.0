Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2720A73D26
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jul 2015 20:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6RK1vLU012422; Mon, 27 Jul 2015 21:01:57 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id T4G6pYHmNwTS; Mon, 27 Jul 2015 21:01:57 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6RK1hIw012407
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 27 Jul 2015 21:01:55 +0100
Message-ID: <1438027303.821.279.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Mon, 27 Jul 2015 21:01:43 +0100
In-Reply-To: <CABcZAN=pWRrz2NQ8=fChBo4MBgfZHjA=weY-=588HfQRgisdSw@mail.gmail.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
	<CABcZANkHbT0R6HY5jtuCN+LLnJ2fVJV2nSVa5u_VCcTdzrct9w@mail.gmail.com>
	<6E51916E4A1F32428260031F4C7CD2B6101D2743@ORSMSX109.amr.corp.intel.com>
	<CABcZAN=pWRrz2NQ8=fChBo4MBgfZHjA=weY-=588HfQRgisdSw@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Mon, 27 Jul 2015 20:02:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2015-07-27 at 10:58 -0700, Christopher Larson wrote:
> 
> On Mon, Jul 27, 2015 at 9:10 AM, Bystricky, Juro
> <juro.bystricky@intel.com> wrote:
>         I agree that a generic solution is preferable. I also I think
>         it is only prudent to support all valid URLs.
>         
>         The situation is complicated by the fact that at present it
>         may not be possible to determine how to interpret the ‘;’ in
>         SRC_URI.
>         
>         It can be part of the URL or it can be a SRC_URI
>         delimiter/separator.
>         
>         As I don’t suppose changing the delimiter character from
>         semi-colon to something else (i.e. an unsafe URL character)
>         
>         is an option, some other changes to the SRC_URI syntax are
>         needed, for example:
>         
>          
>         
>         1.      Some form of escape sequence (i.e. ‘;;’ means treat as
>         ‘;’) in URL, i.e.
>         
>         SRC_URI =
>         "http://abc123.com/git/?p=gcc/gcc.git;;a=snapshot;;h=a5dd47;downloadfilename=abc.tar"
>         
> 
> 
> This is probably the only sane bet to retain compatibility, at least
> as far as I can tell, but perhaps someone else has an idea.
>
>         2.      Quoted string implementation, using one of the
>         “unsafe” URL characters such as ‘`’, to delimit  the URL
>
>         SRC_URI = "’
>         http://abc123.com/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47`;downloadfilename=abc.tar"
>
> Clearly this would be ideal, and is what we should have done, but it’s
> a bit late now :) It’s not the only questionable choice we made in the
> URL handling back when we wrote the original fetcher (e.g. file://
> rather than file:, but afaik one should only use the former if there’s
> a netloc/host).

Yes, horse has bolted now. A bit like a lot of bitbake, hindsight is
great! :}.

There is an alternative I've been mulling over the weekend:

http://abc123.com/git/?p=gcc/gcc.git;extraparams=`;a=snapshot;h=a5dd47`;downloadfilename=abc.tar"
or
http://abc123.com/git/?p=gcc/gcc.git;extraparams=a=snapshot%3Bh=a5dd47;downloadfilename=abc.tar"

(or some variant of that, pick your favourite quote characters and ;
placement is for discussion). We'd then just pull out extraparams and
unescape it somehow. Each fetcher could then deal with it as
appropriate, or its just a wget fetcher specific option.

Just thinking out loud really...

Cheers,

Richard







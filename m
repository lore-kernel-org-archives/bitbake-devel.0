Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
	[209.85.215.54])
	by mail.openembedded.org (Postfix) with ESMTP id 312B070E45
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 21:28:04 +0000 (UTC)
Received: by mail-la0-f54.google.com with SMTP id b17so3404325lan.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=LssN02U6kqUWKNvv2oYb2Op1PCXTSpdhC+0yBsb7N0A=;
	b=uFBErEZTaVlwLQ8+aWUQEkGg6mrwQ9LkhOUF+VmYYfalbTxVG3VBU7pLMEiEjePP7v
	gN8w9OiyybVscXsAkZsiDAAaORcFSjU+I+dPCz6Ev/9iYwgNakX6+YuY6rOOOT7/CJkC
	OCub6KqtAff8Uh7h8OQq70RqiOwmArN0819IWR3xS8trTBRW26JrXLZFWkUbSiDcEwX8
	IUw9vLoLsbvSM5CW4lwj2ebkVF0MLJVe/WONM+V3qaKLdcyy0CCy0F8vXNKc0rxXSjsp
	i+kxdmDyNo4NbT2DCuWGGb2ZiRYBYzgY09vurnw2zflHnwIvCzg52da/8iTBeFNB770P
	5uYA==
X-Received: by 10.152.30.100 with SMTP id r4mr13316938lah.87.1409347685365;
	Fri, 29 Aug 2014 14:28:05 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.43.42 with HTTP; Fri, 29 Aug 2014 14:27:45 -0700 (PDT)
In-Reply-To: <CACS+7ZSnwyCS0YnEd7X=3oHtVmhc3u80GbfMd85UfEYoznVz2Q@mail.gmail.com>
References: <CACS+7ZSnwyCS0YnEd7X=3oHtVmhc3u80GbfMd85UfEYoznVz2Q@mail.gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 29 Aug 2014 14:27:45 -0700
X-Google-Sender-Auth: a2y04pDbi04__X53BwCUx4ns9IQ
Message-ID: <CABcZANkcGjMrXtO5Ew2p9ODJb+KT2rmvAmE_yh+45Fut50n5jA@mail.gmail.com>
To: Dan McGregor <danismostlikely@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] knotty: ignore interrupted system calls
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
X-List-Received-Date: Fri, 29 Aug 2014 21:28:09 -0000
Content-Type: multipart/alternative; boundary=089e0158cba026bc530501cb5431

--089e0158cba026bc530501cb5431
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 29, 2014 at 12:46 PM, Dan McGregor <danismostlikely@gmail.com>
wrote:

> From: Dan McGregor <dan.mcgregor@usask.ca>
>
> With the improved exception handling added in an earlier commit bitbake
> now stops when recieving a SIGWINCH. This happens frequently when
> disconnecting and reconnecting tmux sessions and bitbake didn't survive.
> Restore old behaviour of ignoring interrupted system calls but keep
> proper exception handling for other errors.
>
> Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
>

Oh thank goodness, this has been biting me repeatedly over the past day.
Thanks.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0158cba026bc530501cb5431
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><div class="gmail_extra"><br><div class="gmail_quote">On Fri, Aug 29, 2014 at 12:46 PM, Dan McGregor <span dir="ltr">&lt;<a href="mailto:danismostlikely@gmail.com" target="_blank">danismostlikely@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=":mo" class="a3s" style="overflow:hidden">From: Dan McGregor &lt;<a href="mailto:dan.mcgregor@usask.ca">dan.mcgregor@usask.ca</a>&gt;<br>


<br>
With the improved exception handling added in an earlier commit bitbake<br>
now stops when recieving a SIGWINCH. This happens frequently when<br>
disconnecting and reconnecting tmux sessions and bitbake didn&#39;t survive.<br>
Restore old behaviour of ignoring interrupted system calls but keep<br>
proper exception handling for other errors.<br>
<br>
Signed-off-by: Dan McGregor &lt;<a href="mailto:dan.mcgregor@usask.ca">dan.mcgregor@usask.ca</a>&gt;</div></blockquote></div><br></div><div class="gmail_extra">Oh thank goodness, this has been biting me repeatedly over the past day. Thanks.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--089e0158cba026bc530501cb5431--

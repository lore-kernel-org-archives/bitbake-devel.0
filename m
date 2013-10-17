Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
	[209.85.215.45])
	by mail.openembedded.org (Postfix) with ESMTP id 91C216BA14
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 21:33:15 +0000 (UTC)
Received: by mail-la0-f45.google.com with SMTP id eh20so2374971lab.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=dSLWPZ5EF2Y8mhc+3LGCVQkOwsdmVUXF6aM4AOjOwN0=;
	b=Wk5eY2QvucdZm9D8GlGn0DsVhlsQ5Z632CTiqM/6KU5yQEMIC7J4y1rlfBRjDYM1IF
	yza26slKtVhTEcQnSRw3dLs9usqQle8lp57ZQLFhgHJ51XZo6e/EZz446ploqf0ZgRCf
	yv/e2IBnlVqszRHyyxC0NY3b7SoerE7qOP3eiSDUKhOsWFWxuvpHV2z9eRynl9ak/hHv
	N7Qq+VQgkYneCm/k3A7mmdj+B2GTL8+tv2UccnC+dvaIxv2Zp5Mz28WuGKLNne5U7gXK
	vik64T/J7la3KArq0RL4gFwrAtFEPnxhFuOu2yjCm6Kz7XVU8J90k/3nzkXI9HryKmYI
	yrEQ==
X-Received: by 10.152.22.131 with SMTP id d3mr3789698laf.35.1382045596254;
	Thu, 17 Oct 2013 14:33:16 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.53.197 with HTTP; Thu, 17 Oct 2013 14:32:56 -0700 (PDT)
In-Reply-To: <1382023375-16167-1-git-send-email-olof.johansson@axis.com>
References: <1382023375-16167-1-git-send-email-olof.johansson@axis.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 17 Oct 2013 14:32:56 -0700
X-Google-Sender-Auth: WQMnCpM7ZNZFy_Zveu7KPNe28Zo
Message-ID: <CABcZAN=zaEutkUUP9t9TKR4yqZ5EvP_tiOTioJ-R2qUk1BeYsQ@mail.gmail.com>
To: Olof Johansson <olof.johansson@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] monitordisk: lower inode check warning to note
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
X-List-Received-Date: Thu, 17 Oct 2013 21:33:16 -0000
Content-Type: multipart/alternative; boundary=089e0158b866d4085704e8f69064

--089e0158b866d4085704e8f69064
Content-Type: text/plain; charset=UTF-8

On Thu, Oct 17, 2013 at 8:22 AM, Olof Johansson <olof.johansson@axis.com>wrote:

> Filesystems like btrfs and reiserfs sets the inode count to 0, since
> they don't have an inode concept. This is excepted, and having a warning
> show up every time you run bitbake can cause undue concern.
>

s/except/expect/ :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0158b866d4085704e8f69064
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><div class="gmail_extra"><br><div class="gmail_quote">On Thu, Oct 17, 2013 at 8:22 AM, Olof Johansson <span dir="ltr">&lt;<a href="mailto:olof.johansson@axis.com" target="_blank">olof.johansson@axis.com</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=":ng" style="overflow:hidden">Filesystems like btrfs and reiserfs sets the inode count to 0, since<br>
they don&#39;t have an inode concept. This is excepted, and having a warning<br>
show up every time you run <span class="il">bitbake</span> can cause undue concern.</div></blockquote></div><br>s/except/expect/ :)<br>-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>

Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--089e0158b866d4085704e8f69064--

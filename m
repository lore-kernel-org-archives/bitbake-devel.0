Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
	[209.85.220.182])
	by mail.openembedded.org (Postfix) with ESMTP id D1A0C73D17
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 19:45:04 +0000 (UTC)
Received: by qkhg7 with SMTP id g7so100694284qkh.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=dhqKLmLGZWTBhbDC/aWUMMYUtI3SUsmKqzL1h7or7bI=;
	b=FxNOZ70e1J22rzXmmUICZGP68HXLUwbptxCKBILAI8dJ0AwOZa0uuMIzky+psZCEC9
	2nGLyyV3qZbG/C2vaLpxZvOYKHHcZZuTlOXvL2a4dXEPrQwVKeXEkRMtfYGtfHrdjPe5
	kZLLXMip6UzKQMw1KTcBu12nbgZqJCCv9bkyoP9LPtH0w+hM2bdtKr/cU4IEkisdR0vx
	1WS3MakMwyTHv9LoiLZvFEm5NkCc8GN39TDMw3lOWZqVQ3tcklmf7eKIFxPo/BQnX8H/
	dskJOgzu1QS1zn5nnjyIY60QxH3o8NQZp4nuL45fk4jq+ZO+fwJDZ8uSedfiyh7CtO9z
	JFBw==
X-Received: by 10.140.102.17 with SMTP id v17mr33224091qge.96.1429127074245;
	Wed, 15 Apr 2015 12:44:34 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.34 with HTTP; Wed, 15 Apr 2015 12:44:09 -0700 (PDT)
In-Reply-To: <552CDD04.8040204@windriver.com>
References: <cover.1425969366.git.Qi.Chen@windriver.com>
	<0db087157f7aeabca45cf27e64b200dea9b08c41.1425969366.git.Qi.Chen@windriver.com>
	<552CDD04.8040204@windriver.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 15 Apr 2015 12:44:09 -0700
X-Google-Sender-Auth: HWuQ8GJKYacOJjN6mvhCiiwjN70
Message-ID: <CABcZANnggA2_MQacVB=7JZv5fLku1JCvzL1RfU2fNgk+89=EYg@mail.gmail.com>
To: ChenQi <Qi.Chen@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake-diffsigs: consider the situation where sigdata and siginfo files having the same hash values
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
X-List-Received-Date: Wed, 15 Apr 2015 19:45:05 -0000
Content-Type: multipart/alternative; boundary=001a11c172129973be0513c89368

--001a11c172129973be0513c89368
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 14, 2015 at 2:25 AM, ChenQi <Qi.Chen@windriver.com> wrote:

> ping
>
> Any comment on this one?
>
> Best Regards,
> Chen Qi
>

Seems like this would be an important fix to have, from my perspective..
Honestly I didn't even know about the -t argument until I saw this :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c172129973be0513c89368
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Apr 14, 2015 at 2:25 AM, ChenQi <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:Qi.Chen@windriver.com" target=3D"_blank">Qi.Chen@windriver.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":16l" class=3D"=
a3s" style=3D"overflow:hidden">ping<br>
<br>
Any comment on this one?<br>
<br>
Best Regards,<br>
Chen Qi</div></blockquote></div><br>Seems like this would be an important f=
ix to have, from my perspective.. Honestly I didn&#39;t even know about the=
 -t argument until I saw this :)<br>-- <br><div class=3D"gmail_signature">C=
hristopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenE=
mbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Ment=
or Graphics</div>
</div></div>

--001a11c172129973be0513c89368--

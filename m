Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 162A16E630
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 21:09:22 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id n202so4765012oig.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=rASYOa4X7DVILbx9Nt/w013blKJT+SugjVE40Vek2CY=;
	b=FVseb3k9dYaVZBNP46YM8yBprkI7QnMBRxaAcks7ouBL8ZwrzsHnEi+j5YjKz1LVah
	J62ZH7PuZa/qYePt+CC924yfLZBQu3CPz7O2KFUz6uhqxFqLMrJJPW+OH2RtkyYRglsf
	YDeQJNzFms737xCwsA5aI/AvrAoEEUebH9CEJCuBG3Y3VlUq3LqpquNCy2rX00PIW2Iv
	cmpG7ShkFkq26yBztaFqoJG/J+/19ulgbKctudIphFIbt9Z02+83+GWZePtDi7jzzK5U
	C9tDPtvECNWGrteAqQhelpfyCe2LN2QvWOg7HOd5ogTfOfR+YzDsXGNtjuDb/NkeJs7K
	5W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=rASYOa4X7DVILbx9Nt/w013blKJT+SugjVE40Vek2CY=;
	b=ICCQtzIBvMnTohPdMTXrldETNgc2GvZQ087dVXC29ABypSU8Tr+SkU47P6O3qAEvYd
	ogdzzLxjvW3kCd9LiM2r3QzCOkX2w2fD4HAMvHsyGPK4NYqVAEuPjS/sVbU6iXgeTFTo
	EtQPGBzcbn23dzC2Xmi9DgknZhghULjGmaL3/v9KtaSn8CRl6vYjK0JQUoNT0b0p8CAj
	fgUG5vODP9q0K4R2NTxaqPYe46IElq5IRliNcFzGkNJf08luuGI2mtSsf3yMlyqkvtpl
	58AiBIiuyPg1dPezm482DO9i6M1CH+y6hhq5atf33BiSTWTB2V3o71VYvtj6wUCV1x7w
	/Y2g==
X-Gm-Message-State: AE9vXwP5GDoYTANKFuvmT2nv8jqK39f6QfWEL8rAczSyLqnRkXlTIBHFE+nAylJygAUmRu5vvhyYy+FIfc/lvQ==
X-Received: by 10.202.197.148 with SMTP id v142mr51324451oif.110.1474492163705;
	Wed, 21 Sep 2016 14:09:23 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Wed, 21 Sep 2016 14:09:03 -0700 (PDT)
In-Reply-To: <1474476535-22713-1-git-send-email-ross.burton@intel.com>
References: <1474476535-22713-1-git-send-email-ross.burton@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 21 Sep 2016 14:09:03 -0700
X-Google-Sender-Auth: PMtifLVK_sx2jL8NAgDZayxEy-s
Message-ID: <CABcZANnst0mGfk-FT2=s6c-2CLaCz3EVbMU2u2jGjixfRXb1sQ@mail.gmail.com>
To: Ross Burton <ross.burton@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: handle absolute paths in subdir
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
X-List-Received-Date: Wed, 21 Sep 2016 21:09:24 -0000
Content-Type: multipart/alternative; boundary=001a1134fd2ea4816d053d0af569

--001a1134fd2ea4816d053d0af569
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 21, 2016 at 9:48 AM, Ross Burton <ross.burton@intel.com> wrote:

> Currently if you use the subdir parameter in a SRC_URI and pass an
> absolute path
> then it gets appended to the unpack directory instead of being used
> directly.
> This is inconvenient as it may be useful to use ${S} when you want to
> unpack a
> file into the source tree.
>
> Change this behaviour so that absolute paths are used directly instead of
> being
> appended to the root directory.  To ensure that recipes cannot write files
> to an
> arbitrary location enforce that the subdir starts with the unpack root.
>
> Signed-off-by: Ross Burton <ross.burton@intel.com>
>

Looks good to me, thanks for your work on this.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134fd2ea4816d053d0af569
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Sep 21, 2016 at 9:48 AM, Ross Burton <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":jf" clas=
s=3D"a3s aXjCH m1574da6b2303c7e4">Currently if you use the subdir parameter=
 in a SRC_URI and pass an absolute path<br>
then it gets appended to the unpack directory instead of being used directl=
y.<br>
This is inconvenient as it may be useful to use ${S} when you want to unpac=
k a<br>
file into the source tree.<br>
<br>
Change this behaviour so that absolute paths are used directly instead of b=
eing<br>
appended to the root directory.=C2=A0 To ensure that recipes cannot write f=
iles to an<br>
arbitrary location enforce that the subdir starts with the unpack root.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@intel.com">ros=
s.burton@intel.com</a>&gt;</div></blockquote></div><br>Looks good to me, th=
anks for your work on this.<br>-- <br><div class=3D"gmail_signature" data-s=
martmail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot c=
om<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>=
Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1134fd2ea4816d053d0af569--

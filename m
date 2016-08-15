Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id D6D8576536
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 14:47:38 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id b22so4554276oii.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=p/M+/ci7PjjuzNE9UCBDHxgVxRpzcod5siVH29K+y6c=;
	b=prnLfTdXSg5icKD7rVE5rnCdmJrNqPO45BYk3feEA3TGJ/DWwzcLWHPtMfh5jFPC2+
	l463cxQGpa5EOy4CQpBj29dSkNmIhDe99LVVEj51AgGlFcZbMwLUlRUT8PD3YUfbuwyj
	g87why3nGkZx4XiVtW8T6TTkK6rJ0OsWvVgPTPwNoYuz0SEZnrex0sCdLxyAdxwhcO7U
	T3YkfftAyPGAn5wmLI921KKSY0f0Eq9EmvQX0NMgN9cgSZrlETrHjabqQIZyfG3d3fbT
	ZSUzaKFTCXAhXwZRphEkxVERkOBrJ2RrPpIVYVvaWL7q5EBIfFB9VaICTYNaDbfpd1B7
	0XVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=p/M+/ci7PjjuzNE9UCBDHxgVxRpzcod5siVH29K+y6c=;
	b=boqseCzISLAL/BLc59ux+oBoAhoeVUkTSoRWq7SexJoa7SJVS61Ph9LofvXYMBeIgb
	FIcJou2WKvjioZ6pdyELd+ecWwoDr8Wt/SDqWfM6hjEoYlXaNY22i9LSA+rsfTH2QDm0
	9MJ+woSQJIiX+uWXnEbfUZNud7Zkyk4K8gYd8b8PlMprmrqs1hG+RXCgYVOpWWI/+Abi
	LL4HS0A0G1TRLAPT+jWDbRlH45yYfw6rBb33W782maLXQvxvVg03UxkoAH/kBNgKhHP1
	8b5eF0ZiFh5+EED/qeYJ3kDHOMgn79dvAn78WSEQidJgzq4DGNElYMRuodeM5mo8Qd23
	Fpeg==
X-Gm-Message-State: AEkoousst26/zjMXhs66uU5uaF4DqR0HZ2Es7b6845K9PK3KI/BG1g80v2VqjxAsxix/h95LdTjuyLUXCEb+fw==
X-Received: by 10.202.223.132 with SMTP id w126mr1052594oig.20.1471272458820; 
	Mon, 15 Aug 2016 07:47:38 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.3 with HTTP; Mon, 15 Aug 2016 07:47:18 -0700 (PDT)
In-Reply-To: <14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
References: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
	<1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>
	<14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 15 Aug 2016 07:47:18 -0700
X-Google-Sender-Auth: 4rq-9iCUOyvssI-PKkClydfFEH8
Message-ID: <CABcZANnzPGjXXvMqmOiVSG4sTYTk0y5iKRZdpCk9Fg+4DHHqQg@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@openwide.fr>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	=?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@enst-bretagne.fr>
Subject: Re: [PATCH 1/1] add a syntax to clear variable
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
X-List-Received-Date: Mon, 15 Aug 2016 14:47:41 -0000
Content-Type: multipart/alternative; boundary=001a113d40be46a18f053a1d50af

--001a113d40be46a18f053a1d50af
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 15, 2016 at 7:44 AM, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> How will this interact with ?=, ??=, _append and _remove?
>
> Shouldn't there be unit tests for this? It seems like it can easily
> break and/or be broken by other changes.
>

It's implemented as an immediate operation, so it'd happen long before ??=,
_append, or _remove are applied. ?= is also immediate, so isn't relevant --
?= before it would do nothing, as the unset would undo it, and ?= after the
unset would apply fine.

I think that's the most sane approach for something like this. If you want
the operation postponed, you can use anonymous python for that. Agreed re:
unit tests, though.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113d40be46a18f053a1d50af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 15, 2016 at 7:44 AM, Peter Kjellerstedt <span dir=3D"ltr">&lt;<=
a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank">peter.kjell=
erstedt@axis.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv id=3D":2a6" class=3D"a3s aXjCH m1568ea9f9d3743de">How will this interact=
 with ?=3D, ??=3D, _append and _remove?<br>
<br>
Shouldn&#39;t there be unit tests for this? It seems like it can easily<br>
break and/or be broken by other changes.</div></blockquote></div><br>It&#39=
;s implemented as an immediate operation, so it&#39;d happen long before ??=
=3D, _append, or _remove are applied. ?=3D is also immediate, so isn&#39;t =
relevant -- ?=3D before it would do nothing, as the unset would undo it, an=
d ?=3D after the unset would apply fine.</div><div class=3D"gmail_extra"><b=
r></div><div class=3D"gmail_extra">I think that&#39;s the most sane approac=
h for something like this. If you want the operation postponed, you can use=
 anonymous python for that. Agreed re: unit tests, though.<br>-- <br><div c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature">Christopher Lar=
son<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZ=
aurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</d=
iv>
</div></div>

--001a113d40be46a18f053a1d50af--

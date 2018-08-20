Return-Path: <raj.khem@gmail.com>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
	[209.85.220.174])
	by mail.openembedded.org (Postfix) with ESMTP id A370078FFA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Aug 2018 16:40:59 +0000 (UTC)
Received: by mail-qk0-f174.google.com with SMTP id z78-v6so9054344qka.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Aug 2018 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=kI4Y9jHrsxBmJz8ZGVhXHBSqd1oe7+wG0I3sH2YprE8=;
	b=pFQoFzpLFEZIkVhgBlpzS50GaU/H2cH0rOCCp0U77BfSAWUSMYSXnHG0OGNrA8xrsE
	KQrNOfjvPmZ4KtDMvgpolbCjY9R8gCKNKkuLO3b6vxIAOviV9iJwWKdq1ZDcN+pZxLlU
	/urPeMSpGEFFybeJ14e8sOv+fec5BYsq8Wb4g/XEuAzy+YA5HA3EuwQc/oqbnbyjPe+a
	gv2IYvirgsK4yOAZj18zDqKrYMcFNQbHoGNOBn9Yc0S4M3+ZnlDaovqlkMHqZEHKgp7s
	+k6kELIFqGMVJrGeaq/RGw3Kww9h56sgNM44Fm68NbDCCURWx8rTzI6HgChQjajiyIIS
	sBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=kI4Y9jHrsxBmJz8ZGVhXHBSqd1oe7+wG0I3sH2YprE8=;
	b=iCTcZUi6lcoKAZijiXqmq4Q3FQA5txBw7aNoLD/I5csnibXxd4TqMlxwJEWyPw+mBt
	JLlDjjR8odHtOOlfE4+7229URWSwFfBorJSDHsRgH9fBc8IlQ5Rlb6eUTOPERWoaYZmP
	2BqsB09QaJXN0JihuUKeQRcTax5Vl02U41RjKzwm1IqLMObaUlr1JB1z+gyLw+1gT/6J
	YYOyQCjQiEqMWWq+RnHcAhqjsDihGHWMl2GzGhDsqggcI7sPi7vT0hkhhOOIqcmD+IHF
	DDJ/5N9VBnKY76IIfLZbgnyrc1xntwAiHHAqb/UV4O/nzwPDIf2bq0pV05kgXfZiIwso
	pLUQ==
X-Gm-Message-State: AOUpUlEZBqU06jywxK4HPnM1FUSTG9kFCXpkacoTdFyKPSUDP9GDDZ65
	WbAOKlh/9csYfwxi/QPqaEIsk8uIrApBrCqlBi5eoA==
X-Google-Smtp-Source: AA+uWPy+z2Ox6NJ7efwqkMaWf4HwCUyo6QkESUpkeh4vD6xRhCxY2+zmv6Y66kqedicx7MRXbIUUInVAlRew53HPAC8=
X-Received: by 2002:a37:4a94:: with SMTP id
	x142-v6mr41264588qka.110.1534783260319; 
	Mon, 20 Aug 2018 09:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <be55ff135cbc4483ab4483660d5a0870@HIMDWSMB03.ad.harman.com>
In-Reply-To: <be55ff135cbc4483ab4483660d5a0870@HIMDWSMB03.ad.harman.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 20 Aug 2018 09:40:33 -0700
Message-ID: <CAMKF1sooMOTKT8x8K6Bx8rDQ4PhtgHhTyAL_=8YtH9k=+uuBUA@mail.gmail.com>
To: Ivan.Slaev@harman.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: mistake in chapter 2.1
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
X-List-Received-Date: Mon, 20 Aug 2018 16:41:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 1:14 AM Slaev, Ivan <Ivan.Slaev@harman.com> wrote:
>
> Dear bitbake-devel (community) :),
>
> While I was reading the 2.1 chapter of bitbake manual, I thing I found a =
mistake in:
>
> The layer.conf files are used to construct key variables such as BBPATH a=
nd BBFILES. BBPATH is used to search for configuration and class files unde=
r the conf and classes directories, respectively. BBFILES is used to locate=
 both recipe and recipe append files (.bb and .bbappend). If there is no bb=
layers.conf file, it is assumed the user has set the BBPATH and BBFILES dir=
ectly in the environment.
>
> In my opinion the last sentence should be: If there is no layer.conf file=
, it is assumed the user has set the BBPATH and BBFILES directly in the env=
ironment.
>
> Please check my statement as I could be wrong about it.
>

layer.conf file is used to define many variables along with BBPATH and
BBFLIES which are interesting in context for bblayers.conf file, and
its rightly mentioned in last sentence as well but I see that there is
a bit of disconnect here probably  where reader can get confused
between layer.conf and bblayer.conf, it could be
improved, maybe adding a sentence about what bblayers.conf does before
the last sentence above to put some context could be better.

> Kind regards!
>
> Ivan Slaev
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


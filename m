Return-Path: <armccurdy@gmail.com>
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
	[209.85.217.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8FF967F80F
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Jan 2020 06:34:42 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id n27so2681705vsa.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 22:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Po0C3iOG58PLhl5loN+Xlr3DXZWjg7+hgR3gsoYv9Fw=;
	b=k67K/8RXm0HoLttxh/cvPdkNGCUnHjJ2Ms8Klf4ZE4ZWd+k83sNxOMHp0yc4m45AzQ
	Pjr3BL/krPc9ROjemVEzHFt+Ea8/z/OMxk/DU+3jxPv/2MOyEbD9u72gkR6SZ8GmORnm
	ykbmPMykxW4kqyATgzBE8EVRe6lrW9vRVAODioEGmurR9BDrJVKefbBsbKOvjx5IerHz
	ExWl6sNqdyNaVS+SMU10re8KbWa7/gl67jmiFPwL/ls5GWAVFcy2dEK7sHXc2SaROyrE
	PMzB5G3gITzZ+qfxQKvI2nYsXI22SGHSLqibuwNl1wKGgA8b0ldRZh9uCukkDOmLOgVC
	f1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Po0C3iOG58PLhl5loN+Xlr3DXZWjg7+hgR3gsoYv9Fw=;
	b=K6GXjaFQzIdOtX0iBcs6CucIvO6b8wC4gnWeCXis6j3NYgj05cffbBAn44EmWATM+w
	OBuEEkwGirJlZhDH/lOZZPTMvVU/9nuJtttoEJ7LeZY4D2wLcvUEuYW1APse8nJ7Gd+b
	241n7epOmZkH1a/PH4kP356awN/irWPgWywRJAWpwRbnn4Lun/10VQHmZKUCYv5ZwIxo
	DB0T2D34324J9F997cNlqvRz7JypK2ruk3k4+ubIfIe9Zi2CqxTEkDUQe8AbD8U6sV1H
	O8c8vDseMAyerDCLZ/1DNN1nNHs38qi+TaffrxuKqR5GzwdlxiR/kW1nveeryV4GtTie
	VaKQ==
X-Gm-Message-State: APjAAAU0yr68dU0vxgspqduLoH/7LhMw6+Ko+jJwSOosQIDS2ec1lIyo
	bGpzAA4AZ1imqHdEGakLDm/F1rFCO1CXU8ZtFUxFAQ==
X-Google-Smtp-Source: APXvYqwYHX8m3QcjSmWLBmFvPbmKk6KCs28hMlKjRk32cyUuj01QpMZSl82lprs5zDZ5Drk2tCPZzu2MnnWP/5XKwjE=
X-Received: by 2002:a67:f51a:: with SMTP id u26mr4469475vsn.11.1579934083243; 
	Fri, 24 Jan 2020 22:34:43 -0800 (PST)
MIME-Version: 1.0
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
	<CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
	<b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
	<a4d78a27-50e6-ee87-bcd7-71694b7da60f@linux.intel.com>
	<CANNYZj8S5A1qKy8m_=pPfP_Hbqs7qzYqE-rwMf+DGE0ivnBxpA@mail.gmail.com>
	<4fef2d1e-5fcc-5143-5cf9-cac5ea30b442@linux.intel.com>
	<f9dbd756-6bed-d3ec-f3db-8b2da765b99f@linux.intel.com>
In-Reply-To: <f9dbd756-6bed-d3ec-f3db-8b2da765b99f@linux.intel.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Fri, 24 Jan 2020 22:34:32 -0800
Message-ID: <CAJ86T=V7P6-oXp6HSw2c31ObBRBQOqU=esetXK7cZkD-8vaXEA@mail.gmail.com>
To: =?UTF-8?Q?Adrian_Ambro=C5=BCewicz?= <adrian.ambrozewicz@linux.intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: devtool hardcodes using 'git' patchtool which causes errors
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
X-List-Received-Date: Sat, 25 Jan 2020 06:34:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 2:03 AM Adrian Ambro=C5=BCewicz
<adrian.ambrozewicz@linux.intel.com> wrote:
>
> I've tried yet another approach, leveraging that this project is built
> using cmake and it worked! I know it's not a generic fix, but it looks
> like in bitbake nothing is really generic...

An alternative approach (perhaps the official generic solution?) may
be to use S=3D"${WORKDIR}/git/project_dir", (re)create your patches from
the top level of the git repo without any extra strip levels etc and
then specify "patchdir" for each patch in SRC_URI, e.g. in your case
patchdir would be set to ".." in order to apply patches from the
directory one level above ${S}.

SRC_URI +=3D "file://mychanges.patch;patchdir=3D.."


Return-Path: <eu@felipetonello.com>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id D1A6B75D59
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jul 2015 15:47:47 +0000 (UTC)
Received: by obbnt2 with SMTP id nt2so28897481obb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jul 2015 08:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=/YGuYJuoBh8qLsmKIseM0ozKcvpcoQCZ52rpRStpM1g=;
	b=jrGBRNBYEfbXVkpZW8j4+Fsh1zJQ3Z5X+fkkWx0d+HmiTZSY4jgpB9W4xaEVG0eoxz
	FHZBBZ8uC46Jm6fTz/F4BiLWyXD4GqkP501JsQ10xN4rl+0+XvICJQrY8MbJUDoEht35
	WW4ZSXJ2lQZusMGh+eWLAlfuz+QuEGu/Ho4rybtSLJYCFHvanEP+nB0bJwiM8q6iUK2C
	BGUkVj15FV6BXeJpwAWQN8grDOWnRICq4g9tLqmb+06hlrjz7UXhA4cRLDg61L4y2VTE
	ibgyzDzTUrErVpCCVsrTJrXFRPXXE+SC/eD0nmNkTz9zRoD9enOZWuXCN+RRpo+nL7wP
	ITiQ==
X-Gm-Message-State: ALoCoQnGRAKrODGU42/YOqCvwFIFviaIyNhrZrIGqdFPiPFU/sZ4AnYonXcVw08vLJUqDpj5/MJE
MIME-Version: 1.0
X-Received: by 10.60.175.72 with SMTP id by8mr31978185oec.35.1436197667378;
	Mon, 06 Jul 2015 08:47:47 -0700 (PDT)
Received: by 10.76.147.66 with HTTP; Mon, 6 Jul 2015 08:47:47 -0700 (PDT)
In-Reply-To: <CABcZAN=QEu+w5Zv53kXLPgFTFhsFrfQb_jxJbvbCNuymJbKuqA@mail.gmail.com>
References: <1436195638-24806-1-git-send-email-eu@felipetonello.com>
	<CABcZAN=QEu+w5Zv53kXLPgFTFhsFrfQb_jxJbvbCNuymJbKuqA@mail.gmail.com>
Date: Mon, 6 Jul 2015 16:47:47 +0100
Message-ID: <CAGrhNMzdMS9ckWNHhKL1P=Uta4Q6VbJECzsGx085gDLjcXFCPQ@mail.gmail.com>
From: Felipe Tonello <eu@felipetonello.com>
To: Christopher Larson <clarson@kergoth.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: Remove unecessary code for git submodules
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
X-List-Received-Date: Mon, 06 Jul 2015 15:47:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On Mon, Jul 6, 2015 at 4:38 PM, Christopher Larson <clarson@kergoth.com> wr=
ote:
> On Mon, Jul 6, 2015 at 8:13 AM, <eu@felipetonello.com> wrote:
>>
>> From: "Felipe F. Tonello" <eu@felipetonello.com>
>>
>> Only do git submodule update after upack, otherwise the branch and commi=
t
>> id
>> will be ignored, causing to run git submodules on a wrong ref.
>>
>> Since .gitmodules file is used to check if there is any submodule, we
>> don't
>> need to worry about copying .git/modules directory into the unpacked
>> source
>> tree.
>>
>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>
>
> We don=E2=80=99t want to be downloading from remote locations in do_unpac=
k, only
> do_fetch. This patch will result in the opposite, which means the submodu=
le
> sources won=E2=80=99t be included in the git mirror tarball, and it=E2=80=
=99ll be impossible
> to build with BB_NO_NETWORK=3D1. Also -c fetchall won=E2=80=99t result in=
 all sources
> having been fetched, which defeats its purpose.

I understand. So Ideally we want to checkout to the right ref before
doing the git submodule init && update? Because the way it is today it
doesn't work if the .gitmodules is in a different branch rather then
the default.

The git submodule init && update was previously in the unpack()
anyway. Should I remove it?

Felipe


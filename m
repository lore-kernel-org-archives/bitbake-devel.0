Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by mail.openembedded.org (Postfix) with ESMTP id 57B477DAFD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 16:48:49 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id w12so4196494ljh.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=LIGkV8prtqj7Cr1PaqBcQoUqmuGHS2zWEl+7RcL/1LY=;
	b=us6qjwSSY8nQVWAWGD8koLGPcduJnZrWvHzJsF1QkaOOftw8Y3dBTF0fSw721vlUi0
	p+5cNsmjXalnE5lmJP0vkLHaXdA8I8VxWHht4bMGMXcFv9MmKqYorvdbXh0ne3WeE8GQ
	kVW9jb8h88E9L3qnjuF0nMaU+JOLfSTb1fg8TtKNb+ObHstPd2acfT0WH9SrZdGBGyCj
	0+EM/Pcyvf6eFmkjW44hiUtOfHA0kSZSlXGxmJXXHDqnCTwm4RBD8F02EmY3oqaNzhBp
	eJIK1LMSG26D1Oooty/vqgElPyJPoIUN2+IGCug4H0IbfUvTfE8Pas5usOUsOP+d8DPL
	IINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=LIGkV8prtqj7Cr1PaqBcQoUqmuGHS2zWEl+7RcL/1LY=;
	b=p0aR+2FNUKbN1/9QSgRF7LPk/poQ3RJy9J1qMpurTgikSh+UiYPCv7rC8cVMs6fTcr
	z6hR1lHUEqwBMMjnXKVzkz2a0xbwSaAk5GZoFg4w+uGgGAMq1EAsOWxdhXb3a5XCBNaN
	kIWyBhlMA1sac9AXHwCXWOOh/nomWFrivxwX0lViAuVFA7Lrm4ufTF7JpL50Rz8PIgKU
	260iwpwBP4WcGGPi3wVo8086Fp4spkCLcPTFPlhe502ME+2XoyVqWLUm51vL8S27gPwK
	01kfb7PUkIXWY7/eLzMWvtq7tIU3oEQIb9IJoCpB7muZb23irJz7QonsVH6zsQ3FIpb1
	qyyg==
X-Gm-Message-State: APjAAAXzbCYW9j/eSWsqIepcS5fL7/3l/GsZZBaRS9TddSRBkOMF8YAS
	o4KcZ9ZuwKTjvp0Bra9QpXsxLXLFoHdtpyWeOBzfdw==
X-Google-Smtp-Source: APXvYqzET0rU48/yhXC9xHpN1fbMa4Zh69hdU4fKOyspcnOiQpcKUiD7v42kaiw/JD5nlluCch2PIzHJbkEhneNmIzQ=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr10358386ljg.145.1556729329808;
	Wed, 01 May 2019 09:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
	<9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
	<0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
	<CAPbeDCnOwvCVx-okYiXU0CXjWLxDGBX7xQc4ij+_iGgd2t-T-w@mail.gmail.com>
	<CAJTo0LapxS3a00e31b9ur32x4XtNPTWUSmw4i=_x9AjbLuECjQ@mail.gmail.com>
In-Reply-To: <CAJTo0LapxS3a00e31b9ur32x4XtNPTWUSmw4i=_x9AjbLuECjQ@mail.gmail.com>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Wed, 1 May 2019 18:48:38 +0200
Message-ID: <CAP71WjxDASA04Fz6Fd6ew2FQPZFbtU9gMFJKoUiYVmKUNkbyag@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Wed, 01 May 2019 16:48:49 -0000
Content-Type: text/plain; charset="UTF-8"

On Wed, May 1, 2019 at 5:30 PM Burton, Ross <ross.burton@intel.com> wrote:
>
> On Wed, 1 May 2019 at 11:51, Jacob Kroon <jacob.kroon@gmail.com> wrote:
> > I'm getting a lot of these warnings after removing tmp/ and rebuilding
> > my image from sstate cache.
> > FWIW I use rm_work.bbclass, and regularly use the
> > sstate-cache-management,sh script to prune old cache.
>
> There's a patch I hacked up in master-next that shows where these
> warnings are coming from.  Yes, this patch produces two warnings per
> recipe with rm_work enabled.

argh... i hit the same issue and came up with the exact same
conclusion.. i should have checked the mailing list earlier today ;)

I am getting thousands of warnings like that with rm_work. I had
modified bitbake so that it shows the 'task' name like Ross, in ().

WARNING: zip-native: dependent task do_deploy (do_rm_work) does not exist
WARNING: zip-native: dependent task do_package_write_ipk (do_rm_work)
does not exist
WARNING: zip-native: dependent task do_deploy
(do_build_without_rm_work) does not exist
WARNING: zip-native: dependent task do_package_write_ipk
(do_build_without_rm_work) does not exist
WARNING: zip: dependent task do_deploy (do_rm_work) does not exist
WARNING: zip: dependent task do_deploy (do_build_without_rm_work) does
not exist
WARNING: zip-native: dependent task do_deploy (do_rm_work) does not
exist
WARNING: zip-native: dependent task do_package_write_ipk (do_rm_work)
does not exist
WARNING: zip-native: dependent task do_deploy
(do_build_without_rm_work) does not exist
WARNING: zip-native: dependent task do_package_write_ipk
(do_build_without_rm_work) does not exist
WARNING: zip: dependent task do_deploy (do_rm_work) does not exist
WARNING: zip: dependent task do_deploy (do_build_without_rm_work) does
not exist
WARNING: zip-native: dependent task do_deploy (do_rm_work) does not exist
WARNING: zip-native: dependent task do_package_write_ipk (do_rm_work)
does not exist
WARNING: zip-native: dependent task do_deploy
(do_build_without_rm_work) does not exist
WARNING: zip-native: dependent task do_package_write_ipk
(do_build_without_rm_work) does not exist
WARNING: python-cython: dependent task do_deploy (do_rm_work) does not exist
WARNING: python-cython: dependent task do_deploy
(do_build_without_rm_work) does not exist
WARNING: python-cython-native: dependent task do_deploy (do_rm_work)
does not exist
WARNING: python-cython-native: dependent task do_package_write_ipk
(do_rm_work) does not exist
WARNING: python-cython-native: dependent task do_deploy
(do_build_without_rm_work) does not exist
WARNING: python-cython-native: dependent task do_package_write_ipk
(do_build_without_rm_work) does not exist

>
> Ross
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


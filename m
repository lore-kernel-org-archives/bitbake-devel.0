Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bue@praqma.net>) id 1TTtW2-0006oR-5N
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Nov 2012 13:04:54 +0100
Received: by mail-oa0-f47.google.com with SMTP id h1so2362978oag.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Nov 2012 04:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type:x-gm-message-state;
	bh=Jd2lSCGcIDyuiJJVURmVfYD7t9upZ+y8GQ2Wl5zX0dw=;
	b=P1lvGut4LNuPhLmUAK6A3C+KNka+B/HfytWEw3gRm5CPDddxfH+J3sLHocCVJS6Bhh
	VvvHTymh23uIvPI89MGhTKH7HHtpAKUrMuxJfCpl817fyMZdmYDdJcMfvbx3iPBBKmL1
	lBu7NSrTd9Ztmvf0isKewjRclcoRSGxAV+z0qGEvGP1hPDGyGzzStBbNNlnKljCluHjX
	Dq4200CqaNWNLII0wUej4io0s1HuMG0/18V0IMEWbhHNFIxhxFFUDvjdXj84F47hmLzD
	yqGveMOQjLsbYMiR1ewyYQlMcl28B6k7aFVSbrSaYsKyE36TzPH/DaYv/t/NznCEe3LI
	74OA==
MIME-Version: 1.0
Received: by 10.182.12.40 with SMTP id v8mr32496630obb.12.1351770675560; Thu,
	01 Nov 2012 04:51:15 -0700 (PDT)
Received: by 10.60.12.161 with HTTP; Thu, 1 Nov 2012 04:51:15 -0700 (PDT)
In-Reply-To: <1351769719.6502.16.camel@ted>
References: <CAJB+B4Xwq+O6pPr34ufVQ0Jnpis1gfxbVAyWWF+5eLin8CQ_-Q@mail.gmail.com>
	<1351769719.6502.16.camel@ted>
Date: Thu, 1 Nov 2012 12:51:15 +0100
Message-ID: <CAJB+B4Vu0uh8sXdbw7k-euEchGB+B_j1jD7_KmgrRn_1paXzTw@mail.gmail.com>
From: Bue Petersen <bue@praqma.net>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQkgbYtePTjsAnUbRS4jx4dzHRjyYmh8LjJTrYyx/Ba3n56IC5VqJRr5xXaQ3rs3m4Xn/yOz
Subject: Re: SDK install path and versioning
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 01 Nov 2012 12:04:54 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 1, 2012 at 12:35 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Tue, 2012-10-30 at 08:50 +0100, Bue Petersen wrote:
>> We are using bitbake + openembedded to build a custom linux platform
>> with an image and a SDK for Qt development.
>> I have some questions on how to achive some goals regarding automated
>> testing. Really hope you can help.
>
> Firstly, you'd probably get more help with questions like these on the
> openembedded-core mailing list as these are questions about the
> metadata, not the bitbake tool itself.

Thanks - I read that to in your archive, after I asked the question. I
will use the other list next time.

>
>> 1) how can we "stamp" a version number in the image? I found
>> IMAGE_BASENAME for changing the filename, but I would like also to
>> leave some kind of version number that can be checked on the running
>> system. What is best practice there?
>
> Have a look at adding some kind of rootfs postinstall function e.g.:
>
> ROOTFS_POSTPROCESS_COMMAND += "rootfs_update_timestamp ; "
>
> (see image.bbclass and core-image.bbclass for examples of those)
>
>> 2) Regarding the SDK I would like to install it on a custom path. The
>> normal setup is system-wide on /usr/local/ as I can see. I need to be
>> able to install several at different locations. Maybee even just in
>> the workspace where we develop the Qt-application so I always know
>> exactly which is used for the test. I found the SDKPATH and
>> SDKNATIVEPATH to change this, but do we really need to set the exact
>> path at build time?
>
> This was a newly added feature in the recent danny release branch. The
> SDK is now wrapped in a script which asks you for the location to
> extract to so the binaries support relocation now. You need to use danny
> or master to have this functionality available.
>
> Cheers,
>
> Richard
>
Thanks for the pointers.
The SDK scripts sounds interesting ... I will immediately try it and
update our bitbake+opemembedded clones to latest.

Best regards,
Bue Petersen



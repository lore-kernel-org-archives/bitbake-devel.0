Received: from mail-ve0-f169.google.com ([209.85.128.169])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ross.burton@intel.com>) id 1U8qbq-0006GZ-97
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Feb 2013 12:16:12 +0100
Received: by mail-ve0-f169.google.com with SMTP id 15so405166vea.14
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Feb 2013 02:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:x-gm-message-state;
	bh=O+UQ+mTTILpLAaxobepN6LKu9vghTcpD7fOkfc0XWEA=;
	b=kvnlGbu6PBti6VcbGJ6m/7OfLDg/tvPlqMIqd95wk9Eh+b+we+ozJStZQGEuO2bIk4
	TwHDsGivR9TikAAssZC/zoq3vJG7vn4lJZ7b+V+kI2d2WngSIBTUUSRL8Vi9g4Xqhp+X
	kG3vzEcUP3iYBwXRvPargElCAS9Gzo/LOsrZkRbKx3GuiZSmMbB402OQ306hY19fYwnc
	xWNlQnixAzafAmIzOWVBvczek2r3F+llbbO/S+PpEOykAM5jGxH7y40B1sQAcZYCwFYr
	F5S6YGP3RbBygbVAlO/u/a5a7nK0RWe7RGlqRd/G433M4pQurbTy00lFX7SExgK4OcdT
	5iYA==
X-Received: by 10.58.30.7 with SMTP id o7mr1981341veh.19.1361530796429; Fri,
	22 Feb 2013 02:59:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.58.85.36 with HTTP; Fri, 22 Feb 2013 02:59:36 -0800 (PST)
In-Reply-To: <5126BB39.6000405@yoctoproject.org>
References: <5126BB39.6000405@yoctoproject.org>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 22 Feb 2013 10:59:36 +0000
Message-ID: <CAJTo0LYjvGUUps=Bx5HiS+0dXXM7wbhkMAm7-jKrP2oc-mWz_g@mail.gmail.com>
To: Michael Halstead <michael@yoctoproject.org>
X-Gm-Message-State: ALoCoQn+a/oJjkN3KKGRXthKhDEODsOuJs8ci1BG4SZgbf5xONv40UFYNlZuh6GFujIQqgrvT946
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: [1.16] Re: btrfs fix for 1.3.1?
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
X-List-Received-Date: Fri, 22 Feb 2013 11:16:29 -0000
Content-Type: text/plain; charset=UTF-8

Hi Michael,

On 22 February 2013 00:26, Michael Halstead <michael@yoctoproject.org> wrote:
> Can we include this fix in 1.3.1? If so we can start testing builds on
> btrfs regularly.
>
> http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?id=b0587077a47b2af0d88e17613fb48787e4c11716
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3609

Looks good to me.  1.3.x is using the Bitbake 1.16 branch, so CCing
bitbake-devel to merge the patch in there (bitbake rev
b2ada3ad5f7aefff107f013e0c9decea481c7ef6).

Ross



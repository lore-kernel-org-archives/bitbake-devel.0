Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
	[209.85.213.176])
	by mail.openembedded.org (Postfix) with ESMTP id 3997860767
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Feb 2016 20:55:11 +0000 (UTC)
Received: by mail-ig0-f176.google.com with SMTP id 5so67341934igt.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Feb 2016 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:cc:content-type;
	bh=aQup9ArmEjw0X3b6sZqWq3ln3Co9erZhUfeYpK6Qn24=;
	b=ZVDBJlsHV+1+KwMsN0+MIyIUXQkWKfnTDzismoduaxIfqidteMLgD2Nmbhr79yLJnj
	z7E5+IQ+QOkD7HuMGU+kimB93xIEKQn7gN6/dHThynxZnumaFiJuf54hjGag2DjIUPuH
	dBCX3pkQL3hZwD533fNr5Hyaupkrse3z49hr0Je1y4ABnKMWJFyv5nLBp1jsJQ+4XnbZ
	FruCjtTHgF1jrQ0qSWmDnuTTvFH80W0N+kIaZBiwSsdCjZtmEs9pDTgIEaBlMCkkC525
	yEcc+UcFtp2wi3fvVC3xhlQc3dCJJvJfdMaXFA8X4JRWd7+BX3ugJ7A1A++C7oPm6kBV
	cUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
	:content-type;
	bh=aQup9ArmEjw0X3b6sZqWq3ln3Co9erZhUfeYpK6Qn24=;
	b=Tr3lcIyr4COKa4b97rFiOX46YPl204kdO96mHrhA00zmyiyyWKhpngMRKKJk8Hf2sG
	wcOSCVAgvtLRx5PRMHnX92ESVHyJaGWC639XR/lM87C5tQhOcPpxUCiif75ZGSPeNxXt
	IjGa1Ibup8xt9gFYjFFQDhKwKT+pNFKH9723FMaMfQmxpdFkDEAH97iE1JIBJAuZQkRX
	4mqcP+FlIPjzeMZwzTcp7U1ehlWnWDt2ZYtFapMpj8a8K9Bt5kXFXWWI1RHnnfVuOtjn
	gVS/ukQQ70qUnH9lT5Wn4EmlaThm9gNSGdvNhg2+76pzwZQTDQcZT3xzxVzp5PM6cxFJ
	cReA==
X-Gm-Message-State: AG10YOTsvVAR10Z41GTuCAsxzv8c4pDPxCPLHjjc/+ZyTDEzOsAgVEb7O/5X50mjH0KdXH+AG/yXXjzCvzqrIQ==
MIME-Version: 1.0
X-Received: by 10.50.155.5 with SMTP id vs5mr840699igb.83.1454964912693; Mon,
	08 Feb 2016 12:55:12 -0800 (PST)
Received: by 10.107.164.73 with HTTP; Mon, 8 Feb 2016 12:55:12 -0800 (PST)
Date: Mon, 8 Feb 2016 12:55:12 -0800
Message-ID: <CAKV_0ejg9r8oZxD5gejtx1+=5UHhgOR2oSiPb8drO52dkEChKw@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [BRANCH_PULL] toaster: add image cutomization
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
X-List-Received-Date: Mon, 08 Feb 2016 20:55:14 -0000
Content-Type: text/plain; charset=UTF-8

This is a large patch set (61) that adds the image customization
feature to Toaster.

The branch is poky-contrib/bavery/submit/michaelw/bitbake/ic-7.  This
branch is a signed off version of the
poky-contrib/michaelw/bitbake/ic-7 with the temporary FSTYPES fix
removed.

-brian


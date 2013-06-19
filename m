Return-Path: <btraynor@gmail.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 01D6D601AF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 13:52:04 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w57so4544571wes.15
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=ojQz5ZxCoHqaaUKdQa4z/wJ4JWljyS8y88lRYB7DlSo=;
	b=rFtdpm4K0S+KlehX8CkCL6Oo8Mr/yXyG5qf3PItNSlik2Dcl9B21MbreeGRBE1w0SM
	6Q8jt7dw/iMJPVf8SqxdLifSCQrx1OICSdwfXBgww0vtWAcczJJp8gAC9j19r7euHIK1
	l5dDbd4MF6DIYI8t0c6n7FxL+7uWKprlYAOngtwuUWQUTH2k9zfPRsVM5AM9urutG9eK
	qWHYA44RDxYNZhNg96GV+x+IaWskT2nT1ycKof4dTQx8EjPeFvWolLvvpr5SIQjqktM+
	AvUiBQX9qoBfbF9t+b2umT8Y4Wi2GoNHrET1JVd81i765RmE1rp2dopfXn0DstSrTxEI
	Mo2Q==
X-Received: by 10.194.21.231 with SMTP id y7mr2222564wje.94.1371649925455;
	Wed, 19 Jun 2013 06:52:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.16.69 with HTTP; Wed, 19 Jun 2013 06:51:25 -0700 (PDT)
From: Bill Traynor <btraynor@gmail.com>
Date: Wed, 19 Jun 2013 09:51:25 -0400
Message-ID: <CAN20qYpYGS6huZ+MV8xTpJDyfwJR9mN6o=m5qKMwuJVEqFqf9A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: User Manual: HelloWorld example questions.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Jun 2013 13:52:05 -0000
Content-Type: text/plain; charset=ISO-8859-1

NOTE:  The following questions are posed within the context of the
BitBake User Manual rewrite.

In working through the following two HelloWorld examples:

http://www.mail-archive.com/yocto@yoctoproject.org/msg09379.html
http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/

there are some concepts that I don't quite understand.

1.  The simplest HelloWorld possible would only require a recipe and
source, correct?  The concepts of Classes and Layers is beyond the
basics, is it not?  Or is the simplest of HelloWorld examples without
concepts such as Classes and Layers essentially pointless?

2.  Why isn't there a sample base.bbclass in the bitbake source tree?

3.  I think it would be very beneficial to understanding BitBake to
build out the HelloWorld example beyond the basics, incorporating and
explaining each concept along the way.  My thinking is that given the
true value of BitBake is in the building of complex systems, it would
be beneficial to walk through the concepts as simply as possible to
demonstrate the concepts that require leverage to accomplish this.
This would both demonstrate how BitBake works whiile avoiding overuse
of OE or YP project examples.  Is this idea reasonable, or beyond the
scope of the User manual?

That's all for now.  I appreciate the feedback.

Bill


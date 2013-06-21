Return-Path: <btraynor@gmail.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id EDCB9601D6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 15:41:06 +0000 (UTC)
Received: by mail-wg0-f44.google.com with SMTP id m15so6535575wgh.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=Pp0OskDwi2YThzoUVHHOJgUvni47bK7roPrriPB6NO4=;
	b=e5YmHkX+kXeV/2jnIt176REkYLa2Mc+RnOfo/oS3e+kjeXRWhsXDLHRW9rphjkdLo2
	jTSEU3uq/W+6YCQDYCQFso24XbylA8/td+8HRfTe6/v/b/5HZLgKeLnZRe8bGRj9/3XI
	p3TEBShW0eRWy9/wlomOrHF99I+jG4L1E9Oc3AuBSPobb6E9cJhQ0VBRhxjUKAnadJtO
	aFTUqSS/fbIbFhRNii+OyTfk1YnHhHeGhrwoHlL+cuepdRjB4icLPudWWByevFX+k+Ho
	D29N4S87ceokjx9lkTLcHUCpMzIxgO1bPaKTmc5q2rrDhqgNj38l6ern7cX4um/SoMXH
	CXfw==
X-Received: by 10.180.73.113 with SMTP id k17mr3205194wiv.17.1371829267421;
	Fri, 21 Jun 2013 08:41:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.16.69 with HTTP; Fri, 21 Jun 2013 08:40:27 -0700 (PDT)
In-Reply-To: <CAN20qYpYGS6huZ+MV8xTpJDyfwJR9mN6o=m5qKMwuJVEqFqf9A@mail.gmail.com>
References: <CAN20qYpYGS6huZ+MV8xTpJDyfwJR9mN6o=m5qKMwuJVEqFqf9A@mail.gmail.com>
From: Bill Traynor <btraynor@gmail.com>
Date: Fri, 21 Jun 2013 11:40:27 -0400
Message-ID: <CAN20qYpwykZ7bMwO3kOvm2hGjZ+ZM5QMa6XWTO6ckt6Km4WeNQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: User Manual: HelloWorld example questions.
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
X-List-Received-Date: Fri, 21 Jun 2013 15:41:07 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jun 19, 2013 at 9:51 AM, Bill Traynor <btraynor@gmail.com> wrote:
> NOTE:  The following questions are posed within the context of the
> BitBake User Manual rewrite.
>
> In working through the following two HelloWorld examples:
>
> http://www.mail-archive.com/yocto@yoctoproject.org/msg09379.html
> http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/
>
> there are some concepts that I don't quite understand.
>
> 1.  The simplest HelloWorld possible would only require a recipe and
> source, correct?  The concepts of Classes and Layers is beyond the
> basics, is it not?  Or is the simplest of HelloWorld examples without
> concepts such as Classes and Layers essentially pointless?
>

To answer myself as I work through my hello world project from first
priciples, i.e. beginning with an empty directory and solving errors
one by one I realize that the concept of Layers is necessary given
that the first configuration file BitBake looks for is bblayers.conf,
which is where I set BBPATH.

> 2.  Why isn't there a sample base.bbclass in the bitbake source tree?

Oops, I meant a sample bblayers.conf, NOT base.bbclass which does
indeed exist.  Does it not make sense to have a bblayers.conf
containing at minimum:

BBPATH := "${TOPDIR}"

Perhaps even comment out the latter with a short explanation of what
un-commenting out implies?

>
> 3.  I think it would be very beneficial to understanding BitBake to
> build out the HelloWorld example beyond the basics, incorporating and
> explaining each concept along the way.  My thinking is that given the
> true value of BitBake is in the building of complex systems, it would
> be beneficial to walk through the concepts as simply as possible to
> demonstrate the concepts that require leverage to accomplish this.
> This would both demonstrate how BitBake works whiile avoiding overuse
> of OE or YP project examples.  Is this idea reasonable, or beyond the
> scope of the User manual?

I'm finding it very valuable to step through a simple example using
the -DDD debug parameter to understand what's going on when I issue
the BitBake command.

>
> That's all for now.  I appreciate the feedback.
>
> Bill


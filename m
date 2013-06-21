Return-Path: <btraynor@gmail.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 84739601D6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 17:22:44 +0000 (UTC)
Received: by mail-wg0-f44.google.com with SMTP id m15so6618593wgh.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=EEmSEjHl207uTp8BNF6YzrTk78tDCMLDrHo+5t5wqNo=;
	b=WZdqo8gEh70F7RE/BvxwmRK+hZUzb3eaXEURoIgCAvizFO8bsLFU4HRR0FcpUjjk4V
	jMw9DQqEDlgU8vBF23Vmm2Sh9moAHcqbugqchroTatHj2B3s+KGmGS01NYjK95H7tmAc
	vfKGlpro1sDYPPAhTggxa689HfnxSFUAEDnOqVQTPeWM6rhCYPEcMWsI9lAn/wzen6dG
	MlpAfnT1JeQ1td7xqfPdT65lIvZLRRvc/vY4f/2K5vGQrpLd+7654V/EIQLl+arv7iSQ
	/eFzJW/YEmGSq08zLmcafbkFXon9JmFh3SvLBuGvhssmmIVN2gwTx2rjov67k2ur6ANW
	fefA==
X-Received: by 10.194.22.1 with SMTP id z1mr9989850wje.14.1371835364579; Fri,
	21 Jun 2013 10:22:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.16.69 with HTTP; Fri, 21 Jun 2013 10:22:04 -0700 (PDT)
In-Reply-To: <1608914.fljIic3iX6@helios>
References: <CAN20qYpYGS6huZ+MV8xTpJDyfwJR9mN6o=m5qKMwuJVEqFqf9A@mail.gmail.com>
	<CAN20qYpwykZ7bMwO3kOvm2hGjZ+ZM5QMa6XWTO6ckt6Km4WeNQ@mail.gmail.com>
	<1608914.fljIic3iX6@helios>
From: Bill Traynor <btraynor@gmail.com>
Date: Fri, 21 Jun 2013 13:22:04 -0400
Message-ID: <CAN20qYpyLkhyjtnwcPAhszQpvUW89zHz9hd=m2hSvTXR8tkQtg@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Fri, 21 Jun 2013 17:22:45 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jun 21, 2013 at 1:03 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> Hi Bill,
>
> On Friday 21 June 2013 11:40:27 Bill Traynor wrote:
>> On Wed, Jun 19, 2013 at 9:51 AM, Bill Traynor <btraynor@gmail.com> wrote:
>> > NOTE:  The following questions are posed within the context of the
>> > BitBake User Manual rewrite.
>> >
>> > In working through the following two HelloWorld examples:
>> >
>> > http://www.mail-archive.com/yocto@yoctoproject.org/msg09379.html
>> > http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/
>> >
>> > there are some concepts that I don't quite understand.
>> >
>> > 1.  The simplest HelloWorld possible would only require a recipe and
>> > source, correct?  The concepts of Classes and Layers is beyond the
>> > basics, is it not?  Or is the simplest of HelloWorld examples without
>> > concepts such as Classes and Layers essentially pointless?
>>
>> To answer myself as I work through my hello world project from first
>> priciples, i.e. beginning with an empty directory and solving errors
>> one by one I realize that the concept of Layers is necessary given
>> that the first configuration file BitBake looks for is bblayers.conf,
>> which is where I set BBPATH.
>
> BitBake does implement most of the support for layers, yes, so as a concept it
> should be covered in the BitBake documentation. You may be able to bring in
> non-OE-specific portions of the Yocto Project manuals to help get started here.
>
>> > 2.  Why isn't there a sample base.bbclass in the bitbake source tree?
>>
>> Oops, I meant a sample bblayers.conf, NOT base.bbclass which does
>> indeed exist.  Does it not make sense to have a bblayers.conf
>> containing at minimum:
>>
>> BBPATH := "${TOPDIR}"
>>
>> Perhaps even comment out the latter with a short explanation of what
>> un-commenting out implies?
>
> I think maybe it ought to have both, since base.bbclass is directly referred
> to by bitbake and thus required. I do wonder if it ought to be made clearer
> that the bitbake.conf provided by bitbake (plus whatever other files we
> provide) is an example that's meant to be copied and built upon rather than
> used and edited in-place; perhaps adjusting the directory structure might help
> with this.

Yes, this is exactly how I'm describing the sample files being used
for HelloWorld, i.e. copy them to the project directory and move
forward from there.

>
>> > 3.  I think it would be very beneficial to understanding BitBake to
>> > build out the HelloWorld example beyond the basics, incorporating and
>> > explaining each concept along the way.  My thinking is that given the
>> > true value of BitBake is in the building of complex systems, it would
>> > be beneficial to walk through the concepts as simply as possible to
>> > demonstrate the concepts that require leverage to accomplish this.
>> > This would both demonstrate how BitBake works whiile avoiding overuse
>> > of OE or YP project examples.  Is this idea reasonable, or beyond the
>> > scope of the User manual?
>>
>> I'm finding it very valuable to step through a simple example using
>> the -DDD debug parameter to understand what's going on when I issue
>> the BitBake command.
>
> Stepping through the HelloWorld example sounds reasonable, however I would
> caution that the debug output does tend to change over time, so introducing it
> may increase the burden of maintaining the manual.

That's a good point.  But it's a burden I'm willing to endure at this
point.  Perhaps once I understand the nooks and crannies of what
BitBake is doing I'll rewrite things to be more descriptive.

>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre


Return-Path: <raj.khem@gmail.com>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
	[209.85.223.176])
	by mail.openembedded.org (Postfix) with ESMTP id A1F0E61013
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 06:52:25 +0000 (UTC)
Received: by mail-ie0-f176.google.com with SMTP id s9so271904iec.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2013 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=HQJkSkmmlMSeovm/jH5EyJBt+jD6AXdLRkUxaXR90s8=;
	b=AJ2POrr+Yp5jeEXLkCwJ4D8vHV42SSGgATIjzh+nJN8LBwHc+Z3lPJp5mx3win2WcF
	qlVDoifD+y0RZLEWn6Y7ESa/AD1y9mH4mJXcgiL5FTlOedZAFHh5xBan4QwwcGYCfi01
	g1V/DJILLgpz8mi3uOArCAQkxJFuVpOj/MzJKkORrVzn2+QMEopbeVrvakhg3lR4Ejs1
	5kqAIyEZ9egdj9diW8SUmM/2HdnlLJO8RjqVSwfIC64KktstKLnnaTH7QRhj2EeIubaS
	pDDkyzYK+8aQ4Qs0rZi4FGNqSqCiYcTiZnNsRz67vutIBJXndyrayg7i9gE34JQ5SdTo
	L/Og==
X-Received: by 10.50.103.3 with SMTP id fs3mr538270igb.39.1377240745880; Thu,
	22 Aug 2013 23:52:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.216.195 with HTTP; Thu, 22 Aug 2013 23:51:55 -0700 (PDT)
In-Reply-To: <CAMvUbCxhEEyp5dCZjN0fidBJxxgX55CXL88ErL5u5bkz1rOdEQ@mail.gmail.com>
References: <1376644859-11034-1-git-send-email-nicolas.dechesne@linaro.org>
	<CAMvUbCxhEEyp5dCZjN0fidBJxxgX55CXL88ErL5u5bkz1rOdEQ@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 22 Aug 2013 23:51:55 -0700
Message-ID: <CAMKF1srp8QVHCtM7p7-dzrVPS5ipMqnDgTPt=spAsN9RVBAFkA@mail.gmail.com>
To: Leon Woestenberg <sidebranch.openembedded@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, patches@linaro.org
Subject: Re: [RFC PATCH] build.py: create symlink for run.do_xxx scripts
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
X-List-Received-Date: Fri, 23 Aug 2013 06:52:27 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 22, 2013 at 7:47 AM, Leon Woestenberg
<sidebranch.openembedded@gmail.com> wrote:
> Hello Nicolas,
>
> On Fri, Aug 16, 2013 at 11:20 AM, Nicolas Dechesne
> <nicolas.dechesne@linaro.org> wrote:
>>
>> The 'courtesy' symlink for log.do_xxx are quite useful when debugging, so
>> with this commit, we now get similar 'courtesy' symlink for run.do_xxx
>> scripts.
>>
>> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
>> ---
>
>
> At least I can +1 on the debugging helpfulness, I would like this feature to
> be in bitbake.
>
> As it's a courtesy link only, the chosen approach seems good to me.
>

yeah its useful. Many times you just want to execute the latest run.doXXX
and it will help there.

> Regards,
>
> Leon.
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


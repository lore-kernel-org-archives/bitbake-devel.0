Return-Path: <parmesh.iiit@gmail.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 1F38972A49
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Apr 2015 09:17:32 +0000 (UTC)
Received: by wiun10 with SMTP id n10so58972333wiu.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Apr 2015 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=gAIf2CwoXG94V5/tMxzl2eTyJc2kr88eMCirzdXsveY=;
	b=dvxP0fQDe/xbICQq2KurnCzlGkSmlInUe65a+BtEk0PksH81kP8snzmabOwSsHMYeK
	ZwofrvLypQyJZmcEt5CS/6ZBXHOYbuvhaf8xnt5EOvTvJbE3r+wGnIxNdMl587GHA0eU
	v6Qjjb56WZPwDL79AowJwItBW8ktd2gV/1313oLqXCmOxYKB24juOiTcKTD9LbbZQFCS
	ep0Wtu02NHY882RMzmfuxuGsIya/kCqSTugufHALp6/T6XJ0DGM7R3ELJI/sWUqs5sDv
	I5LONrWX1mabhTjDk0O1f+qHwmaOE9ughWE8vwbSTVzr+ckseUcdizmvu4713EcHlKfO
	wf8Q==
MIME-Version: 1.0
X-Received: by 10.181.11.129 with SMTP id ei1mr19776624wid.57.1428916653175;
	Mon, 13 Apr 2015 02:17:33 -0700 (PDT)
Received: by 10.180.86.36 with HTTP; Mon, 13 Apr 2015 02:17:33 -0700 (PDT)
In-Reply-To: <2860644.gqf1mWsvVV@peggleto-mobl.ger.corp.intel.com>
References: <CACBNtJZdWOa1nC9ObOyzrXmhLBgpT-qYaWqTqHdhBWdP56bBGA@mail.gmail.com>
	<2860644.gqf1mWsvVV@peggleto-mobl.ger.corp.intel.com>
Date: Mon, 13 Apr 2015 14:47:33 +0530
Message-ID: <CACBNtJZxt1gve567vCnq+86D=m1wj98_5nigLR3O61zSfB2BMg@mail.gmail.com>
From: parmeshwar tak <parmesh.iiit@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Want to fetch only files which are having ".new" or ".replace" extention to the ${WORKDIR}.
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
X-List-Received-Date: Mon, 13 Apr 2015 09:17:33 -0000
Content-Type: text/plain; charset=UTF-8

Hi All,

Can any one share the sample python script to fetch only specific file
from git repo??

On Mon, Apr 13, 2015 at 1:48 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Thursday 09 April 2015 17:55:38 parmeshwar tak wrote:
>> I have a simple problem, any one can answer.
>> I have a repo "rdk\build_script", and branch ="xyz".
>> I need to write a bbappend where the path "patches/Refsw" has some
>> files with ".new" and ".replace" extention.
>>
>> I want to fetch only files which are having ".new" or ".replace"
>> extention to the ${WORKDIR}.
>
> There is no build-in support for this - you'll need to write additional code
> (in the form of python code in a do_unpack_append, or an additional function.)
>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre



-- 
Regards
-----------------------------
~Parmeshwar Tak~
MSIT 2010
IIIT Hyderabad


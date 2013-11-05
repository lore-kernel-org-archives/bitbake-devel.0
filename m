Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 832ED6D160
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Nov 2013 13:17:45 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id rA5DHkoV026343
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 5 Nov 2013 05:17:46 -0800 (PST)
Received: from [128.224.162.242] (128.224.162.242) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.347.0;
	Tue, 5 Nov 2013 05:17:45 -0800
Message-ID: <5278EFF0.7010601@windriver.com>
Date: Tue, 5 Nov 2013 21:17:36 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <1383266185-2917-1-git-send-email-nicolas.dechesne@linaro.org>
	<CAP71Wjz8DXdFYqMER6uy+7X9ic-PJmGQVp+d5ayC4TJ5Eqgozw@mail.gmail.com>
In-Reply-To: <CAP71Wjz8DXdFYqMER6uy+7X9ic-PJmGQVp+d5ayC4TJ5Eqgozw@mail.gmail.com>
Subject: Re: [PATCH RFC] fetch2/svn.py: use log instead of info to retrieve revision
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
X-List-Received-Date: Tue, 05 Nov 2013 13:17:46 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit



On 11/05/2013 02:48 AM, Nicolas Dechesne wrote:
> On Thu, Oct 31, 2013 at 5:36 PM, Nicolas Dechesne
> <nicolas.dechesne@linaro.org> wrote:
>> We have faced a corner case situation where the 'last changed
>> revision' returned from svn info is wrong. It happens when the last
>> revision is a directory move. e.g. if we assume that the svn
>> repository at revA has root/x/y/z/foo/bar and it is moved to
>> root/a/b/c/foo/bar in revB, then svn info 'last change revision' will
>> return revA. As such when using AUTOREV, we are going to attempt to
>> retrieve root/a/b/c/foo/bar (as per SRC_URI) but at revA when it did
>> not exist.
>>
>> So this patch changes how we retrieve the latest revision and uses
>> 'svn log --limit 1' which gives correct result in all tested cases.
>
> Richard, thanks for merging in master. any chance this can go to dora

Hi Nicolas,

I will add it to the queue of dora, thanks.

// Robert


> and dylan too, as this is a bug fix? the same patch applies in both
> branches, and we are currently using dylan and dora for our projects.
>
> thanks
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>


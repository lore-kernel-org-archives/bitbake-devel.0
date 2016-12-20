Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6C8EC772E4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Dec 2016 14:49:02 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id uBKEn3fM021200
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 20 Dec 2016 06:49:03 -0800 (PST)
Received: from soho-mhatle-m.local (172.25.36.231) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 20 Dec 2016 06:49:02 -0800
To: Matthew McClintock <msm-oss@mcclintock.net>
References: <1481880762-26028-1-git-send-email-msm-oss@mcclintock.net>
	<7610040c-55e8-10e1-8451-5c5842c82a60@windriver.com>
	<CAEsOVNeaQi2WybD+RK_5COYN5QSybMPUrSUkNxGhzKRgBALcHg@mail.gmail.com>
	<5a9b5f14-3af6-25b7-c1df-9ddc8d01d804@windriver.com>
	<CAEsOVNfM5TwodxXsZvqrhU7-9KQdaCnTwWZJPvkuD2Nwihi4KA@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <6c61f833-9579-9fab-4f2d-97ee599d618c@windriver.com>
Date: Tue, 20 Dec 2016 08:49:02 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAEsOVNfM5TwodxXsZvqrhU7-9KQdaCnTwWZJPvkuD2Nwihi4KA@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/wget: add Basic Auth from netrc to checkstatus()
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
X-List-Received-Date: Tue, 20 Dec 2016 14:49:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 12/20/16 3:00 AM, Matthew McClintock wrote:
> On Tue, Dec 20, 2016 at 1:50 AM, Mark Hatle <mark.hatle@windriver.com> wrote:
>>> I'm confused how is .netrc dangerous in this regard? The python
>>> library actually won't use netrc if the permissions on the file are
>>> wrong but I'm not aware of how there is leakage here? Maybe you're
>>> just warning against parsing and adding to the command line?
>>
>> The credentials are stored in plain text in .netrc.  This is a problem on
>> multiuser machines, as often user home directories are world accessible, and
>> often users forget to mark things like .netrc as private.
>>
>> Any time a credential is stored in plain text is potentially dangerous if
>> someone can access the users directory.  (I don't consider .ssh credentials in
>> the same category because people and ssh enforce the permissions on the
>> directory for security reasons.  wget does not.)
> 
> Well you can only go so far to protect users, perhaps we could add a
> usenetrc=true flag to URI's and then error if the permissions are
> wrong or even just throw the error from the netrc python lib instead
> of catching it?

I consider this an issue with the programs using the netrc, not bitbake or
others.  (Plus the bitbake can be adjusted to use curl or other programs, not
just wget that may have different semantics, via re-defining the FETCHCMD_wget)

I just wanted to call this out as an issue, because it has been problematic in
the past for us and we had to devise a solution that worked without the .netrc.

> Currently though wget uses netrc and python checkstatus does not so
> I'd claim this is broken as-is.

Agreed.

--Mark

> -M
> 



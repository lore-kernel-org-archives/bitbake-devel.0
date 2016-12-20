Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 10E2077329
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Dec 2016 00:50:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id uBK0oLnN017763
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 19 Dec 2016 16:50:21 -0800 (PST)
Received: from soho-mhatle-m.local (172.25.36.231) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Mon, 19 Dec 2016 16:50:20 -0800
To: Matthew McClintock <msm-oss@mcclintock.net>
References: <1481880762-26028-1-git-send-email-msm-oss@mcclintock.net>
	<7610040c-55e8-10e1-8451-5c5842c82a60@windriver.com>
	<CAEsOVNeaQi2WybD+RK_5COYN5QSybMPUrSUkNxGhzKRgBALcHg@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <5a9b5f14-3af6-25b7-c1df-9ddc8d01d804@windriver.com>
Date: Mon, 19 Dec 2016 18:50:19 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAEsOVNeaQi2WybD+RK_5COYN5QSybMPUrSUkNxGhzKRgBALcHg@mail.gmail.com>
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
X-List-Received-Date: Tue, 20 Dec 2016 00:50:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 12/17/16 3:42 AM, Matthew McClintock wrote:
> On Fri, Dec 16, 2016 at 5:59 PM, Mark Hatle <mark.hatle@windriver.com> wrote:
>> There was a recent change to wget that allows it to do an 'ASKPASS' when it
>> needs credentials.
>>
>> This is how we handle that at Wind River.  We define a WGET_ASKPASS program that
>> knows how to answer the credential questions [or prompt the user outside of the
>> build system, i.e. via gnome].
> 
> This is somewhat tangential to the patch above though? You could still do both.

Yes it is.

>> (Passing anything on the command line, or even via .netrc is really dangerous.
>> The command line due to 'ps' leakage on a multi-user system, and .netrc as the
>> credentials are stored in plain text.)
> 
> I'm confused how is .netrc dangerous in this regard? The python
> library actually won't use netrc if the permissions on the file are
> wrong but I'm not aware of how there is leakage here? Maybe you're
> just warning against parsing and adding to the command line?

The credentials are stored in plain text in .netrc.  This is a problem on
multiuser machines, as often user home directories are world accessible, and
often users forget to mark things like .netrc as private.

Any time a credential is stored in plain text is potentially dangerous if
someone can access the users directory.  (I don't consider .ssh credentials in
the same category because people and ssh enforce the permissions on the
directory for security reasons.  wget does not.)

> -M
> 



Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id E43296DAF8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:22:37 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s2B8MZjW003789
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 11 Mar 2014 01:22:35 -0700 (PDT)
Received: from [128.224.162.226] (128.224.162.226) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.169.1;
	Tue, 11 Mar 2014 01:22:34 -0700
Message-ID: <531EC7C9.7040209@windriver.com>
Date: Tue, 11 Mar 2014 16:22:33 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Javier Viguera <javier.viguera@digi.com>
References: <991B6481567A894BA8E18E29D118D85801558DEB1EF4@dor-sms-exch01.digi.com>
	<53106DFA.6030308@digi.com>
In-Reply-To: <53106DFA.6030308@digi.com>
Cc: "poky@yoctoproject.org" <poky@yoctoproject.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [poky] [for-dora] backport bitbake git fetcher fix
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
X-List-Received-Date: Tue, 11 Mar 2014 08:22:42 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit


Hi Javier,

Thanks for reporting this, I will backport it to dora, sorry for
the late reponse.

Btw. this email should go into bitbake-devel@lists.openembedded.org

// Robert

On 02/28/2014 07:07 PM, Javier Viguera wrote:
> Hi all,
>
> Seems that this didn't catch much attention. Maybe because this is not the
> correct list for bitbake fixes.
>
> I had a look at bitbake git repo and they did not follow the branching scheme in
> openembedded/poky. So where do i need to send a fix for bitbake that i need to
> be included in already-released poky Dora?
>
> -
> Javier Viguera
> Software Engineer
> Digi International® Spain S.A.U.
>
>
>
> On 21/02/14 17:54, Viguera, Javier wrote:
>> Hi all,
>>
>> I'm using Dora with a customer kernel that happens to have two very
>> similar branch names:
>>
>> af186b498eb8e39ffa419d356010d67d7fa6dee3 refs/heads/android/v3.10/master
>> a094f655dc2ba623742a01dcb744ed0e8ebde3ed refs/heads/v3.10/master
>>
>> My custom linux recipe does the following to get 'v3.10/master' branch:
>>
>> KBRANCH_DEFAULT = "v3.10/master"
>> KBRANCH = "${KBRANCH_DEFAULT}"
>> SRC_URI = "${GIT_URL}linux-2.6.git;protocol=git;branch=${KBRANCH}"
>>
>> But it always fetchs the 'android/v3.10/master' branch.
>>
>> This seems to be already fixed in master:
>>
>> d21c1537b7052aa24ec56434b821fee67de33a83
>>
>> So could that fix be cherry-picked to Dora?
>>
>> Directly cherry-picking the commit does not apply cleanly so i attach
>> here a reworked patch that applies to Dora.
>>
>> -
>> Javier Viguera
>> Software Engineer
>> Digi International® Spain S.A.U.
>>
>
> _______________________________________________
> poky mailing list
> poky@yoctoproject.org
> https://lists.yoctoproject.org/listinfo/poky
>
>


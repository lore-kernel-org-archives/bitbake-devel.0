Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1T02ip-0000NG-TI
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Aug 2012 05:50:44 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7B3cpgG010640
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 10 Aug 2012 20:38:51 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Fri, 10 Aug 2012 20:38:50 -0700
Message-ID: <5025D3C9.50104@windriver.com>
Date: Sat, 11 Aug 2012 11:38:49 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <cover.1344569166.git.liezhi.yang@windriver.com>
	<6a3f6d68c2bb44faac061761f2565a5f03d8e8d8.1344569166.git.liezhi.yang@windriver.com>
	<CABcZANkj1Uq30z-uvc5EjNRZOXeCLKp=yWEi6ORxTPtm3jNWWA@mail.gmail.com>
In-Reply-To: <CABcZANkj1Uq30z-uvc5EjNRZOXeCLKp=yWEi6ORxTPtm3jNWWA@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1 V2] bitbake-whatchanged: print what is about to happen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 11 Aug 2012 03:50:44 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 08/10/2012 09:38 PM, Chris Larson wrote:
> On Thu, Aug 9, 2012 at 8:47 PM, Robert Yang <liezhi.yang@windriver.com> wrote:
>> * Usage:
>>    bitbake-whatchanged [[opts] recipe]
>>
>> * Implementation summary:
>>    - Use the "BB_STAMPS_DIR=<path> bitbake -S recipe" to generate the new
>>      stamps
>
> If this script depends on a variable that is metadata specific, it
> doesn't belong in the bitbake repository.
>

Hi Chris,

I think that the problem is this script needs bb.siggen.compare_sigfiles,
if we don't use the bb.siggen, then we can use the
subprocess.Popen(bitbake-diffsigs, ...), but that would be much slower than
bb.siggen.compare_sigfiles.

// Robert



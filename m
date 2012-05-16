Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SUTCn-0007Vc-FF
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 03:39:09 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4G1T5j0011333
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 15 May 2012 18:29:05 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 15 May 2012 18:29:04 -0700
Message-ID: <4FB302DE.4030903@windriver.com>
Date: Wed, 16 May 2012 09:29:02 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <cover.1337073916.git.liezhi.yang@windriver.com>
	<6ca7f7e56bdab86c3920182256220077a94fe78d.1337073916.git.liezhi.yang@windriver.com>
	<CABcZANkHOAe0Fx8hG+_5m-z6jLHNV1hKu2vv01T_TsY1u4H6jA@mail.gmail.com>
In-Reply-To: <CABcZANkHOAe0Fx8hG+_5m-z6jLHNV1hKu2vv01T_TsY1u4H6jA@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 2/2] replace os.popen with subprocess.Popen
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
X-List-Received-Date: Wed, 16 May 2012 01:39:09 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 05/15/2012 10:43 PM, Chris Larson wrote:
> On Tue, May 15, 2012 at 2:53 AM, Robert Yang<liezhi.yang@windriver.com>  wrote:
>> -        p4file = os.popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
>> +        p4file = Popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot)).stdout
>>          cset = p4file.readline().strip()
>
> When all that's being done is reading the output of the command, I'd
> think bb.process.run() would do the job, rather than manually using

Thanks, the bb.process.run() would be better, I will send the V3 sooner.

// Robert

> Popen, no? Once we require python 2.7, we can use
> subprocess.check_output() instead, of course.



Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SUBjl-0003Gd-LF
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 May 2012 09:00:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4F6nxUQ019493
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 14 May 2012 23:49:59 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 14 May 2012 23:49:59 -0700
Message-ID: <4FB1FC95.7020908@windriver.com>
Date: Tue, 15 May 2012 14:49:57 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <cover.1336974361.git.liezhi.yang@windriver.com>
	<a072dd7795f44603322db6583ac748f0418684fd.1336974361.git.liezhi.yang@windriver.com>
	<CABcZANnhObRGgJ0gzM+urLRE5gcWmsECFR59P+HpHYPqannh3w@mail.gmail.com>
In-Reply-To: <CABcZANnhObRGgJ0gzM+urLRE5gcWmsECFR59P+HpHYPqannh3w@mail.gmail.com>
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
X-List-Received-Date: Tue, 15 May 2012 07:00:02 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 05/14/2012 09:59 PM, Chris Larson wrote:
> On Mon, May 14, 2012 at 1:07 AM, Robert Yang<liezhi.yang@windriver.com>  wrote:
>>      def popen_read(self, cmd):
>> -        return os.popen("%s 2>/dev/null" % cmd).read().strip()
>> +        return subprocess.Popen("%s 2>/dev/null" % cmd, shell=True, stdout=subprocess.PIPE).stdout.read().strip()
>
> The 2>/dev/null is irrelevant when we're only inspecting the stdout
> anyway. Also, we already have wrappers around Popen for convenience in
> the bb.process python module.

Thanks, I will remove the 2>/dev/null and use:

from bb.process import Popen

to simplify the code, I will send the V2 sooner.

// Robert




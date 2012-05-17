Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SUq9j-0004aM-Po
	for bitbake-devel@lists.openembedded.org;
	Thu, 17 May 2012 04:09:32 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4H1xReN024940
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 16 May 2012 18:59:27 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 16 May 2012 18:59:26 -0700
Message-ID: <4FB45B7C.2060904@windriver.com>
Date: Thu, 17 May 2012 09:59:24 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <cover.1337147194.git.liezhi.yang@windriver.com>
	<e22ec7981521df200e2db535630b666ce6d2731f.1337147194.git.liezhi.yang@windriver.com>
	<CABcZAN=Li=d73RueP18YRZSB-ExDMkW7EVw_gpF4j72Ch-j5Cg@mail.gmail.com>
In-Reply-To: <CABcZAN=Li=d73RueP18YRZSB-ExDMkW7EVw_gpF4j72Ch-j5Cg@mail.gmail.com>
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
X-List-Received-Date: Thu, 17 May 2012 02:09:32 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 05/16/2012 10:14 PM, Chris Larson wrote:
> On Tue, May 15, 2012 at 10:55 PM, Robert Yang<liezhi.yang@windriver.com>  wrote:
>> Replace os.popen with subprocess.Popen since the older function would
>> fail (more or less) silently if the executed program cannot be found
>>
>> There is a bb.process.run() which will invoke the Popen to run command,
>> use it for simplify the code.
>>
>> More info:
>> http://docs.python.org/library/subprocess.html#subprocess-replacements
>>
>> [YOCTO #2075]
>>
>> Signed-off-by: Robert Yang<liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/perforce.py            |    6 +++---
>>   bitbake/lib/bb/fetch2/svk.py                 |    2 +-
>>   bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 ++-
>>   bitbake/lib/bb/ui/crumbs/hig.py              |    7 ++++---
>>   4 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
>> index 6abf15d..e07afdd 100644
>> --- a/bitbake/lib/bb/fetch2/perforce.py
>> +++ b/bitbake/lib/bb/fetch2/perforce.py
>> @@ -91,7 +91,7 @@ class Perforce(FetchMethod):
>>
>>          p4cmd = data.getVar('FETCHCOMMAND_p4', d, True)
>>          logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt, depot)
>> -        p4file = os.popen("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
>> +        (p4file, errors) = bb.process.run("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
>>          cset = p4file.readline().strip()
>
> This is wrong, and will actually fail badly if you attempt to use
> this. run() returns the values from Popen.communicate(), which returns
> the data as strings, not pipes, so read() and readline() will not be
> available on that object, and aren't needed. Also, the parens aren't
> needed. "foo, bar =" is just as valid as "(foo, bar) =" (minor). This
> should do it:
>
>      output, errors = bb.process.run("%s%s changes -m 1 %s" % (p4cmd,
> p4opt, depot))
>      cset = output.strip()
>
>> @@ -755,7 +756,7 @@ class DeployImageDialog (CrumbsDialog):
>>                  cmdline = bb.ui.crumbs.utils.which_terminal()
>>                  if cmdline:
>>                      cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
>> -                    subprocess.Popen(args=shlex.split(cmdline))
>> +                    bb.process.run(args=shlex.split(cmdline))
>
> This is wrong, and will fail. run() has no 'args' named argument. Try
> not to get discouraged -- we do appreciate the work you're doing, but
> checking this in would break bitbake for a great number of people. I'd
> suggest actually testing bitbake with your changes before sending them

Yes, I had tested the "bitbake core-image-sato" before sent the patch V3,

that's fine, I will send the V4 tomorrow since I'm out of office today:-).

// Robert

> to the list. Thanks.



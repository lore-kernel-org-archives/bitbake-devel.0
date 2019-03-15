Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D6DC96C230
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Mar 2019 02:45:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2F2ivVt027463
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 14 Mar 2019 19:45:38 -0700
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 14 Mar 2019 19:45:09 -0700
To: "Lisicki, Raphael" <raphael.lisicki@siemens.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<8074fc829447468b0f42672f17f31b83d3f3888b.1552555629.git.liezhi.yang@windriver.com>
	<AM5PR10MB18437E4D46F44792D2685E9AEC4B0@AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <37078a74-86c7-39b2-6375-87b7f8fdb8a7@windriver.com>
Date: Fri, 15 Mar 2019 10:50:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <AM5PR10MB18437E4D46F44792D2685E9AEC4B0@AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: [PATCH 4/5] fetch2/gitsm: Add clean function
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
X-List-Received-Date: Fri, 15 Mar 2019 02:46:00 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi,

On 3/14/19 8:34 PM, Lisicki, Raphael wrote:
> I have not fully understand the logic but I am wondering what happens here is a submodule is located in two different repositories? Wouldn't a clean of one module delete submodules of the other one as well?

Here are more explanations about the logic, for example, repo_A has two
submodules repo_B and repo_C, then after do_fetch,
they will be"
DL_DIR/repo_A
DL_DIR/repo_B
DL_DIR/repo_C

Without this patch, do_cleanall only removes DL_DIR/repo_A, but leaves
repo_B and repo_C there, this patch makes it remove repo_B and C.


For your question, if repo_B is submodule of both repo_A and repo_D, it
is like foo and foo-native use the same git source, when you run
"bitbake foo -cccleanall", both foo and foo-native's source will be
removed since they use the same source, the similar to gitsm, so it is not
a problem, the source will be re-downloaded automatically when needed.

// Robert

> 
> Best regards
> Raphael
> 
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>> bounces@lists.openembedded.org> On Behalf Of Robert Yang
>> Sent: Thursday, March 14, 2019 10:28 AM
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCH 4/5] fetch2/gitsm: Add clean function
>>
>> The git's clean can only remove parent git repo from DL_DIR, but doesn't
>> remove
>> submodules, this patch fixes the problem.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/gitsm.py | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
>> index b21fed2..bb61093 100644
>> --- a/bitbake/lib/bb/fetch2/gitsm.py
>> +++ b/bitbake/lib/bb/fetch2/gitsm.py
>> @@ -76,8 +76,8 @@ class GitSM(Git):
>>           for name in ud.names:
>>               try:
>>                   gitmodules = runfetchcmd("%s show %s:.gitmodules" %
>> (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=workdir)
>> -            except:
>> -                # No submodules to update
>> +            except Exception as esc:
>> +                logger.info("No submodules found: %s" % workdir)
>>                   continue
>>
>>               for m, md in parse_gitmodules(gitmodules).items():
>> @@ -164,6 +164,17 @@ class GitSM(Git):
>>           Git.download(self, ud, d)
>>           self.process_submodules(ud, ud.clonedir, download_submodule, d)
>>
>> +    def clean(self, ud, d):
>> +        def clean_submodule(ud, url, module, modpath, d):
>> +            try:
>> +                newfetch = Fetch([url], d, cache=False)
>> +                newfetch.clean()
>> +            except Exception as e:
>> +                logger.warn('gitsm: submodule clean failed: %s %s' %
>> (type(e).__name__, str(e)))
>> +
>> +        self.process_submodules(ud, ud.clonedir, clean_submodule, d)
>> +        Git.clean(self, ud, d)
>> +
>>       def unpack(self, ud, destdir, d):
>>           def unpack_submodules(ud, url, module, modpath, d):
>>               url += ";bareclone=1;nobranch=1"
>> --
>> 2.7.4
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


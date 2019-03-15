Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 12C016C230
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Mar 2019 02:47:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x2F2lARV013861
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 19:47:11 -0700 (PDT)
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 14 Mar 2019 19:47:09 -0700
To: Mark Hatle <mark.hatle@windriver.com>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<8074fc829447468b0f42672f17f31b83d3f3888b.1552555629.git.liezhi.yang@windriver.com>
	<f1dbdece-5627-16a1-4104-3cd37c5369d8@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <645179f8-eeb2-a08b-a7b9-4b680d71a27c@windriver.com>
Date: Fri, 15 Mar 2019 10:52:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f1dbdece-5627-16a1-4104-3cd37c5369d8@windriver.com>
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
X-List-Received-Date: Fri, 15 Mar 2019 02:47:10 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Mark,

On 3/14/19 10:41 PM, Mark Hatle wrote:
> On 3/14/19 4:28 AM, Robert Yang wrote:
>> The git's clean can only remove parent git repo from DL_DIR, but doesn't remove
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
>>                   gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=workdir)
>> -            except:
>> -                # No submodules to update
>> +            except Exception as esc:
>> +                logger.info("No submodules found: %s" % workdir)
> 
> We don't want the log message.  git submodules are processed recursively, and
> the end of the recursion will -always- have 'gitsm' items that have no
> submodules.  This is also why it was a generic except, because we really don't
> care WHAT the exception is, only that if one happens -- we know the command
> failed and to simply ignore it and finish the iteration.
> 
>                    continue
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
>> +                logger.warn('gitsm: submodule clean failed: %s %s' % (type(e).__name__, str(e)))
>> +
>> +        self.process_submodules(ud, ud.clonedir, clean_submodule, d)
>> +        Git.clean(self, ud, d)
>> +
> 
> I don't see 'clean_submodule' implemented in this patch.  The process_submodules
> will simply call that function, if it's not defined it will error or not do
> anything if it finds a submodule.


The clean_submodule is inside of 'def clean', right under 'def clean':

+    def clean(self, ud, d):
+        def clean_submodule(ud, url, module, modpath, d):

// Robert

> 
>>       def unpack(self, ud, destdir, d):
>>           def unpack_submodules(ud, url, module, modpath, d):
>>               url += ";bareclone=1;nobranch=1"
>>
> 
> 


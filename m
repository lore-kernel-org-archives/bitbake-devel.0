Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0T1-0005yz-A4
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:11:27 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5E30kuM009154
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 13 Jun 2012 20:00:47 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:00:46 -0700
Message-ID: <4FD953DD.6030507@windriver.com>
Date: Wed, 13 Jun 2012 22:00:45 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
	<1339162913-23759-15-git-send-email-jason.wessel@windriver.com>
	<1339422729.28854.3.camel@ted>
In-Reply-To: <1339422729.28854.3.camel@ted>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v4 14/18] runqueue.py, build.py: Invalidate setscene tasks based on do_unpack stamps
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
X-List-Received-Date: Thu, 14 Jun 2012 03:11:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 06/11/2012 08:52 AM, Richard Purdie wrote:
> On Fri, 2012-06-08 at 08:41 -0500, Jason Wessel wrote:
>> If you have a fully populated sstate cache and have used it to
>> execute a build, it is not possible to invalidate repackage
>> an intermediate build after you have forced a compiled
>>
>> Example when you have build from a complete sstate cache build:
>>   bitbake core-image-sato
>>   bitbake -c patch acl
>>      *** Make some changes to the C files for experimentation.
>>   bitbake -f -c compile acl
>>   bitbake acl
>>
>> The bitbake will refuse to build the acl package at this
>> point and instead keep populating it from the sstate.  Using
>> the cleanstate is no longer a good option because it will
>> also erase the scratch area.
>>
>> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
>> ---
>>  lib/bb/build.py    |    8 ++++++++
>>  lib/bb/runqueue.py |   14 ++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/lib/bb/build.py b/lib/bb/build.py
>> index fb61b00..18c28aa 100644
>> --- a/lib/bb/build.py
>> +++ b/lib/bb/build.py
>> @@ -463,6 +463,14 @@ def del_stamp(task, d, file_name = None):
>>      stamp = stamp_internal(task, d, file_name)
>>      bb.utils.remove(stamp)
>>  
>> +def exists_stamp(task, d, file_name = None):
>> +    """
>> +    Removes a stamp for a given task
>> +    (d can be a data dict or dataCache)
>> +    """
>> +    stamp = stamp_internal(task, d, file_name)
>> +    return os.path.exists(stamp)
>> +
>>  def stampfile(taskname, d, file_name = None):
>>      """
>>      Return the stamp for a given task
>> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>> index da3fdf9..6c802af 100644
>> --- a/lib/bb/runqueue.py
>> +++ b/lib/bb/runqueue.py
>> @@ -718,6 +718,20 @@ class RunQueueData:
>>                      for dep in self.runq_depends[task]:
>>                          procdep.append(self.taskData.fn_index[self.runq_fnid[dep]] + "." + self.runq_task[dep])
>>                      self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
>> +        try:
>> +            new_setscene = []
>> +            for task in self.runq_setscene:
>> +                try:
>> +                    fn = self.taskData.fn_index[self.rq.rqdata.runq_fnid[task]]
>> +                    if bb.build.exists_stamp("do_unpack", self.dataCache, fn):
>> +                        logger.debug(2, 'Removing task %s from queue because do_unpack exists', task)
>> +                    else:
>> +                        new_setscene.append(task)
>> +                except:
>> +                    logger.debug(2, 'Failed do_unpack check for %s', task)
>> +            self.runq_setscene = new_setscene
>> +        except:
>> +            logger.debug(2, 'Failed to update runq_setscene')
> We've gone to quite a bit of trouble to keep knowledge of the specific
> tasks out of bitbake. I've noticed a few of your patches are "blurring"
> the separation between bitbake and the metadata.
>
> Here, bitbake shouldn't have knowledge of "unpack" or why its special.
> I'd also argue its not in fact special and there are probably other
> "force" scenarios which would break with a similar problem even with
> this patch. I agree there is a problem here but we need to fix it in a
> more generic way. There is already a bug open on this kind of problem
> (#2256).

As I mentioned in the 0/18 summary this is certainly the case that there needs to be an API and this should be treated as more of an RFC.

I will break whole series down into a few smaller chunks since there are some important fixes vs the features.


Jason.



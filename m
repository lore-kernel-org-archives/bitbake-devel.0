Return-Path: <sgw@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id E120577041
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Sep 2015 21:49:50 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2015 14:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,456,1437462000"; d="scan'208";a="554113622"
Received: from ngniech-mobl.amr.corp.intel.com (HELO
	swold-mobl.amr.corp.intel.com) ([10.254.55.139])
	by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2015 14:49:50 -0700
To: Martin Jansa <martin.jansa@gmail.com>
References: <1441214406-11183-1-git-send-email-sgw@linux.intel.com>
	<20150902172736.GF2470@jama>
From: Saul Wold <sgw@linux.intel.com>
Message-ID: <55E76EFE.7050209@linux.intel.com>
Date: Wed, 2 Sep 2015 14:49:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20150902172736.GF2470@jama>
Cc: akuster808@gmail.com, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] prserv/serv: Improve exit handling
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
X-List-Received-Date: Wed, 02 Sep 2015 21:49:51 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2015 10:27 AM, Martin Jansa wrote:
> On Wed, Sep 02, 2015 at 10:20:06AM -0700, Saul Wold wrote:
>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> The subject doesn't say for which branch this is intended.
>
> I guess 1.24, because it's already in 1.26 and master, but it should be
> specified in Subject.
>
Yes it is for 1.24, I can resend, but I think RP knows that this is for 
1.24 also.

Sau!

>>
>> Currently, I'm not sure how the prserver managed to shut down cleanly. These
>> issues may explain some of the hangs people have reported.
>>
>> This change:
>>
>> * Ensures the connection acceptance thread monitors self.quit
>> * We wait for the thread to exit before exitting
>> * We sync the database when the thread exits
>> * We do what the comment mentions, timeout after 30s and sync the database
>>    if needed. Previously, there was no timeout (the 0.5 applies to sockets,
>>    not the Queue object)
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> (cherry picked from commit 0926492295d485813d8a4f6b77c7b152e4c5b4c4)
>> Signed-off-by: Saul Wold <sgw@linux.intel.com>
>> ---
>>   lib/prserv/serv.py | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
>> index 25eb46a..a7639c8 100644
>> --- a/lib/prserv/serv.py
>> +++ b/lib/prserv/serv.py
>> @@ -77,12 +77,15 @@ class PRServer(SimpleXMLRPCServer):
>>
>>           """
>>           iter_count = 1
>> -        # With 60 iterations between syncs and a 0.5 second timeout between
>> -        # iterations, this will sync if dirty every ~30 seconds.
>> +        # 60 iterations between syncs or sync if dirty every ~30 seconds
>>           iterations_between_sync = 60
>>
>> -        while True:
>> -            (request, client_address) = self.requestqueue.get()
>> +        while not self.quit:
>> +            try:
>> +                (request, client_address) = self.requestqueue.get(True, 30)
>> +            except Queue.Empty:
>> +                self.table.sync_if_dirty()
>> +                continue
>>               try:
>>                   self.finish_request(request, client_address)
>>                   self.shutdown_request(request)
>> @@ -93,6 +96,7 @@ class PRServer(SimpleXMLRPCServer):
>>                   self.handle_error(request, client_address)
>>                   self.shutdown_request(request)
>>                   self.table.sync()
>> +            self.table.sync_if_dirty()
>>
>>       def process_request(self, request, client_address):
>>           self.requestqueue.put((request, client_address))
>> @@ -137,7 +141,7 @@ class PRServer(SimpleXMLRPCServer):
>>           self.handlerthread.start()
>>           while not self.quit:
>>               self.handle_request()
>> -
>> +        self.handlerthread.join()
>>           self.table.sync()
>>           logger.info("PRServer: stopping...")
>>           self.server_close()
>> --
>> 2.1.0
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


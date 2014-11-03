Return-Path: <gary@mlbassoc.com>
X-Greylist: delayed 563 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 03 Nov 2014 18:36:38 UTC
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id BBA9E60169
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 18:36:38 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id 0846CF811DB; Mon,  3 Nov 2014 11:27:15 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id 253C1F811D9;
	Mon,  3 Nov 2014 11:27:15 -0700 (MST)
Message-ID: <5457C903.2030703@mlbassoc.com>
Date: Mon, 03 Nov 2014 11:27:15 -0700
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>	<CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>	<20141103154726.GA9716@bshelton-desktop>
	<1415035858.5111.45.camel@ted>
In-Reply-To: <1415035858.5111.45.camel@ted>
Subject: Re: [PATCH] prserv: don't wait until exit to sync
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
X-List-Received-Date: Mon, 03 Nov 2014 18:36:43 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2014-11-03 10:30, Richard Purdie wrote:
> On Mon, 2014-11-03 at 09:47 -0600, Ben Shelton wrote:
>> On 11/02, Burton, Ross wrote:
>>> On 27 October 2014 17:27, Ben Shelton <ben.shelton@ni.com> wrote:
>>>
>>>> In the commit 'prserv: Ensure data is committed', the PR server moved to
>>>> only committing transactions to the database when the PR server is
>>>> stopped.  This improves performance, but it means that if the machine
>>>> running the PR server loses power unexpectedly or if the PR server
>>>> process gets SIGKILL, the uncommitted package revision data is lost.
>>>>
>>>> To fix this issue, sync the database periodically, once per 30 seconds
>>>> by default, if it has been marked as dirty.  To be safe, continue to
>>>> sync the database at exit regardless of its status.
>>>>
>>>
>>> This appears to be causing random problems for me where bitbake will
>>> timeout attempting to access the PR database, my hunch is that it's
>>> blocking on disk I/O.  Are there any tricks we can do with sqlite to reduce
>>> the overhead of committing? (assuming that sqlite isn't causing a full
>>> filesystem sync).
>>>
>>> Ross
>>
>> After running a few large nightly builds, we've seen some issues with
>> this as well.  It looks like the issue is in the PR server itself, which
>> logs this error:
>>
>> "OperationalError: cannot start a transaction within a transaction"
>>
>> However, I'm confused as to why this is happening, since the only place
>> new transactions are being created is in the sync() function ("BEGIN
>> EXCLUSIVE TRANSACTION"), and AFAIK that's only called by a single
>> thread.  Any ideas?
>
> Did the commit() fail and therefore there was already an transaction
> open? It leads to another quesiton of why the commit would fail (timeout
> maybe?).
>
>> Would it make sense to revert the patch until we identify/fix the issue?
>
> You have flagged a valid issue that I would like to get to the bottom of
> so perhaps not quite yet.
>
> I'm wondering if we can have some in memory copy of the table which we
> flush to disk in a separate thread which wouldn't influence the PR
> service request responses but its a horrible idea to workaround what
> seems like a fundamental problem in sqlite :/.

I just got this error:
ERROR: Can NOT get PRAUTO from remote PR service
ERROR: Function failed: package_get_auto_pr
ERROR: Logfile of failure stored in: /home/local/rpi-latest_2014-10-30/tmp/work/armv6-vfp-amltd-linux-gnueabi/usbutils/007-r0/temp/log.do_package.13260
ERROR: Task 3204 (/home/local/poky-latest/meta/recipes-bsp/usbutils/usbutils_007.bb, do_package) failed with exit code '1'

Is it the same as what's being discussed above?  Where can I
look for more info on what happened?

n.b. I just restarted my build and it seems happy to carry on
where it left off.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------


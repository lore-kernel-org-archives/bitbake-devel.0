Received: from mail-lb0-f182.google.com ([209.85.217.182])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martiert@gmail.com>) id 1U6iQ2-0003ax-Fo
	for bitbake-devel@lists.openembedded.org;
	Sat, 16 Feb 2013 15:07:53 +0100
Received: by mail-lb0-f182.google.com with SMTP id gg6so3315022lbb.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Feb 2013 05:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:message-id:date:from:user-agent:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=d5K9l9sLYQ91kmqu/Dn9WuFSNZPvD7wlY+RILek299c=;
	b=aqtwy0RcrF2QxLlbEF29BCKWVVNzqJZQp4rBSTkc6c8K0gjf3ysYY2h8xCqPBAlXJQ
	/GpwJxBQoGkwMmMgiFWymuSM2SvGvKZu5+LlO9o3nYyzdwTdYNtXGA7TryizLLUmTgGQ
	rTHCz3TXYHpDYNhMh15Ljupe+KJ7yqvTpf997/WtEzdxJsr4uJIQDmNjwPVi2F+XmB2X
	k8ylPO+Ngk5LZsVFi/Hutfhr5sVg4ez85YBK4wiV/XbbX/JSLklzInCzqHCP+MYtR1zk
	7mUnr96Mvy69Bhd2mt+aTswpNdO5SafcRsDflOYI0ib7ygMAqu1DAf+GkVp4lm23qelZ
	hM7Q==
X-Received: by 10.152.133.133 with SMTP id pc5mr5215612lab.32.1361022665407;
	Sat, 16 Feb 2013 05:51:05 -0800 (PST)
Received: from [192.168.1.115] ([37.191.128.59])
	by mx.google.com with ESMTPS id hk10sm1428011lab.4.2013.02.16.05.51.03
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sat, 16 Feb 2013 05:51:04 -0800 (PST)
Message-ID: <511F8EC6.1080201@gmail.com>
Date: Sat, 16 Feb 2013 14:51:02 +0100
From: =?UTF-8?B?TWFydGluIEVydHPDpXM=?= <martiert@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130124 Thunderbird/17.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1360281302.10722.68.camel@ted>
	<CABcZANmd9_bcAUizAR3JiSX368HJsKhzGrGPkqAsbMsw2G9=ig@mail.gmail.com>
	<1360944017.31795.1.camel@ted>
In-Reply-To: <1360944017.31795.1.camel@ted>
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils: Use rm -rf in remove()
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
X-List-Received-Date: Sat, 16 Feb 2013 14:08:07 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/15/13 17:00, Richard Purdie wrote:
> On Thu, 2013-02-07 at 18:08 -0700, Chris Larson wrote:
>> On Thu, Feb 7, 2013 at 4:55 PM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>>          -                shutil.rmtree(name)
>>          +                # shutil.rmtree(name) would be ideal but its
>>          too slow
>>          +                subprocess.call('rm -rf %s' % path,
>>          shell=True)
>>
>> This is a good idea, but I'm curious about forking off a shell process
>> for it. I'd think this would work as well: subprocess.call(['rm',
>> '-rf', path])
> path can have wildcards in it. The code wasn't entirely obvious so I've
> tweaked it after your/Peter's comments. I'm hoping it will help the
> problems Martin was seeing too.
>
> Cheers,
>
> Richard
>
>
I think this is a good idea as well. One thing I would question though, 
is to have this in the except clause. Why not:

     for name in glob.glob(path):
         try:
	    if recurse and os.path.isdir(path):
	       subprocess.call('rm -rf %s' % path, shell=True)
	       return
	    os.unlink(name)
         except OSError as exc:
             if exc.errno != errno.ENOENT:
                 raise


Personally I feel it is cleaner to have all the remove possibilities in 
the try, and let the exceptions be in except. Kind of feel it is wrong 
to let the recursive case be handled in the exception, as I don't see it 
being an exceptional case to delete a folder.

Also, unfortunately your patch would not fix osx, as EISDIR is not the 
error that is returned there. What I get is either a EPERM or an EACCES 
(not on a mac now, so can't check it until monday). So osx would still 
fall through to the raise.



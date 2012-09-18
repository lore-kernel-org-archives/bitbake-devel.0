Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDmbe-0006Wr-1i
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 03:28:06 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8I1FNTS005331
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 17 Sep 2012 18:15:24 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 18:15:23 -0700
Message-ID: <5057CB2A.9030508@windriver.com>
Date: Mon, 17 Sep 2012 20:15:22 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
	<1347921818-60562-2-git-send-email-jason.wessel@windriver.com>
	<CABcZANkRiYXarfHjqF9u2tuqyqJZtqDuom3Ueta4AwYxENP_Sg@mail.gmail.com>
In-Reply-To: <CABcZANkRiYXarfHjqF9u2tuqyqJZtqDuom3Ueta4AwYxENP_Sg@mail.gmail.com>
X-Enigmail-Version: 1.4.4
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/8] bitbake: Unbuffer stdout for log files
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
X-List-Received-Date: Tue, 18 Sep 2012 01:28:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 09/17/2012 07:46 PM, Chris Larson wrote:
> On Mon, Sep 17, 2012 at 3:43 PM, Jason Wessel
> <jason.wessel@windriver.com> wrote:
>> It is possible to lose critical log data when python exits in an
>> unorderly fashion via segmentation fault or certain types of crashes.
>> This is because the buffer characteristics are inherited from the top
>> level stdout, which should be set to unbuffered, for the purpose of
>> all the forked children.
>>
>> This pushes the buffering to the OS, instead of having python managing
>> the buffers in its stream handler class.
>>
>> This change is also to provide the ability to tail logs written from
>> processes in "real time" because they would be written in an orderly
>> fashion depending upon the OS characteristics for the file I/O.
>>
>> (LOCAL REV ONLY: NOT UPSTREAM)
>>
>> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
>
> I'm assuming you forgot to rebase -i and remove the LOCAL REV ONLY? :)


Oops :-)

I can resend the patches, but I did re-base against the head but for some reason the filter was not working.

Jason.



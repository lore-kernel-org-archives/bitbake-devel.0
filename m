Return-Path: <rpjday@crashcourse.ca>
X-Greylist: delayed 3550 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 07 Mar 2015 17:15:59 UTC
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 70CE3738ED
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  7 Mar 2015 17:15:59 +0000 (UTC)
Received: from [99.240.204.5] (port=41598 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1YUHPG-0000kP-EV for bitbake-devel@lists.openembedded.org;
	Sat, 07 Mar 2015 11:16:50 -0500
Date: Sat, 7 Mar 2015 11:16:45 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@Device-040570
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1503071053070.28079@Device-040570>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: suddenly confused by appends and overrides being used together
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
X-List-Received-Date: Sat, 07 Mar 2015 17:16:00 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  thought i understood how appending and overrides work together but a
simple example suggests i have no clue.  from the in-progress bitbake
user manual here:

http://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html

section 3.2.3, this first example looks right (start excerpt):

     OVERRIDES = "foo"
     A = "Z"
     A_foo_append = "X"


For this case, A is unconditionally set to "Z" and "X" is
unconditionally and immediately appended to the variable A_foo.
Because overrides have not been applied yet, A_foo is set to "X" due
to the append and A simply equals "Z"."  (end of manual excerpt)

  ok, i buy that ... A is set to "Z", and the statement after that
then appends "X" to the variable (in this case) A_foo. and, if i
understand this properly, that string "A_foo" has no special override
processing because it was, in a sense, protected by the _append
operator. so using chris larson's "bb" utility i can verify:

$ bb show A
A="Z"
$ bb show A_foo
A_foo="X"

  however, i'm confused by the statement above, "Because overrides
have not been applied yet, ...". well, it's not so much that the
overrides haven't been applied "yet" as that they will *not* be
applied in this case, correct? in what way will assigning something to
the expression "A_foo_append" have any effect on the final value of A?

  the next example in the manual right below that also looks correct,
as the override is the *last* part of the LHS expression and is
therefore(?) processed immediately and has an effect:

"This next example changes the order of the override and the append:

     OVERRIDES = "foo"
     A = "Z"
     A_append_foo = "X"


For this case, before overrides are handled, A is set to "Z" and
A_append_foo is set to "X". Once the override for "foo" is applied,
however, A gets appended with "X". Consequently, A becomes "ZX".
Notice that spaces are not appended. (end of excerpt)

and i accept all that as well, as shown by "bb":

$ bb show A
A="ZX"
$ bb show A_foo
WARNING: Requested variable 'A_foo' does not exist

  but it's the next example that's confusing:

"This next example has the order of the appends and overrides reversed
back as in the first example:

     OVERRIDES = "foo"
     A = "Y"
     A_foo_append = "Z"
     A_foo_append += "X"


For this case, before any overrides are resolved, A is set to "Y"
using an immediate assignment. After this immediate assignment, A_foo
is set to "Z", and then further appended with "X" leaving the variable
set to "Z X". Finally, applying the override for "foo" results in the
conditional variable A becoming "Z X" (i.e. A is replaced with A_foo).
(end of excerpt)

  um ... what? in what way is this any different from the *first*
example above, for which the final values are:

$ bb show A
A="Y"
$ bb show A_foo
A_foo="Z X"

  so, no, the final value of A is not "Z X" as the above suggests. am
i misreading this? am i getting misleading answers from "bb"? i'm
having trouble seeing the value of the expression:

  VAR_<override>_append = ...

where i just don't see how that will have any effect on the final
value of VAR.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


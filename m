Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1372C433EF
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 07:41:24 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.92.68.31])
 by mx.groups.io with SMTP id smtpd.web11.21079.1637912483152878070
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 23:41:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=b2kjoEWQ;
 spf=pass (domain: outlook.com, ip: 40.92.68.31,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJW4C+6wAECeZvXubmQZUkhqbDVSEomNBpCS11EMaTY/Uh5gn5OHorbmYnoH7n/UfjLhF377vLW133IVLOlpuahbVzCTR3/XVZiNSTFMWzcG/i3JOCXwplCL24KJAlmwKF5iAK7TTec0oL3CvgjEu2hRvESh11mbwVykw746qicZUbXa2wIKex2IRUrqWKK1lrVS9VNRY+GYQxO/D/4lErYlDGT/BQO6SkghJ5x0bTDGvwSoZOY+NKbHf897VnarQfsLvUr0W6brzlzY+Hyz19ZJZ+ibgewtFMfRts5GWZM2seDtM8eZ5PaXSYMBxk+IvDK4chHRnhfkJCFvOQ52gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=386/yTlgbWM8OuZLKTLV5UZ8o/+KpdVFaavdgjgkhpw=;
 b=Ez5cjk//C6YggFLZgNAsVQabcZ3oUfpUXUdqgp7zI2iaN97NXSFiy/AdIwZ66K+C4DUJIzb5YERaFcn+k52EW3Ou7ZlSMKMVdzeGhzsvDzaQfhtnVw+bcJy97TihLfAP6vKAoXDkT1YUxroXAku9/ycQjz59WkbaZ+K7EPUE5MoVwHupspPM3d2rcCTxEHiIpmXalWRrPGGtFIx47opfPFDJwxbk4FCoK4J6OC+YwTOpBZECDHA2DQ9wo2cWP0EAPujYQ8US1vVazKSMzjt0/7pHM7CgmPnQ3x+JNEH0X0bBOuKBecWea/XwsF1KN96XPlpdbT520J9sJoYNvvTEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=386/yTlgbWM8OuZLKTLV5UZ8o/+KpdVFaavdgjgkhpw=;
 b=b2kjoEWQK4nHtgY3Qs4Xrri/FspdYgfB14nGbZJM2Q1ywZN3pqFUv88aSxVwAbOvINJhdmaK4sNUO3H7gaOyhZPAcA0GnQmprHLr71O38pmS5whtqX9GUtvlEc/kSTODo5WMWGYb7jNFGFAh8irUvgxhEL/fKqiF0t6tqQg0GAdpmiQdVWuy6ES4lgEoAgDP9roT9iBBJE/Mp4GAvRwtnxTxal2xAdcYJEdfsSFynAgpcoMGtCYy/3BcmtmAnhbONjxFvi14GQwzl5i6H3JbI8PtTyv3RkQMfB8G2zktSu3UtqE+PNI7U4DVLLyl14UJExL+2KJ8XKsfB3pjTjNvSA==
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
 by AM0PR09MB2468.eurprd09.prod.outlook.com (2603:10a6:208:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Fri, 26 Nov
 2021 07:41:19 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710%3]) with mapi id 15.20.4734.020; Fri, 26 Nov 2021
 07:41:19 +0000
Subject: Re: [bitbake-devel] [PATCH] lib/bb/version.py: add from
 distutils.version
To: Tim Orling <ticotimo@gmail.com>, bitbake-devel@lists.openembedded.org
Cc: Tim Orling <timothy.t.orling@intel.com>
References: <20211126051800.2364615-1-timothy.t.orling@intel.com>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB46420ABAACE5B920960660EFA8639@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Fri, 26 Nov 2021 08:41:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211126051800.2364615-1-timothy.t.orling@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN: [p/1uCiybK2y9BoAb4qjOFEvX/0AOznYQWQj1aYSHHEute9X4Gh7LnxFHgneShjxs]
X-ClientProxiedBy: AM8P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::28) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
X-Microsoft-Original-Message-ID: 
 <0536952d-bb90-0670-3c81-1e0717fcbb90@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 AM8P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::28) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend
 Transport; Fri, 26 Nov 2021 07:41:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e047839f-3e85-415d-73d5-08d9b0b022c4
X-MS-TrafficTypeDiagnostic: AM0PR09MB2468:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BzvkhDdwyyqobuI2/cKXqWem8Ry4DQdyT46Zy4v528Svp8Cw+2s1WSCWRIazJpfkNHVmZhCp+MBqzIZYm57gty1Odm7zEgd3gQA0LI7JeUi0uhfSSOLFi+LesrRKMjm3GjG2a5lLLtRjf1EOqvArztOisgEJrZcIHSs7Sgqgq0ekGP31AzJvERCYMZ0Hw8CR6cKoLTxwnpqRibgeoCcvQur+SyJ0y1a9Y1UPX5At8x4/YNX6lMH1xi32oPCvIWNSiVQmfWk+/1U9HfGqX/RrEk0CtCQ8LZbrKdpvWLoeyP5/VSegEMTFXlUCDR7SVKWB7BW5db2TgBw2mw5nETzlbMDLzETX228pGgcRf6IoXlTYxumrq50SW6d6EoCdDDgwnpBLa0dM1PmV2nSmxNlavj0JED046ZmpMeVkdUAX1DLB46UiwL5oenXAUFkocVlsI/fBhr8pjykXH4prXRnwlHSKMK4KHAP4p7CT8mir8v8vVwkVQ3+Q6JQrL6eWIsb3WSdBTsEXR2mEQqPvYz9eMP0n6TSu6bdW9nEkKnbV7EtorQwONW6GdM8JfBlmuG4ChK8NypYY5WFIqPYG8mRRQMQmcCVcFVHMQqbwwxsgBCANbL+CmrYTkultLmXXEQWz8X2YXQnP/WpykzLJSqls8JLO1bOkWHceF/NUW58fJg0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	8YturuOALL5J7LBnEHRZ+KEnkfqWbOZgSLbtYp6ZqmTlnhr5XCjQHro57aZMheg8wHJv3BiTIC6lgoSYl3omBt88m16/eb3+xA4vGNe16Zq0J82PeBQhLyFNqGNSe6FAYUoxj76SWn8vm+k7pcvwbbLnQDCSLztWb4lbOHfndwd8UU3p5Urh2xY+VeHPd2tp6pP0BPayTm9uyp7lIuDF9ylGWUBIsZhg0gdSM+UCIWxg5eAF/07LGRzA7DFnXGd5roPym/MaWpFISNArxlln6aeoVehBR31PQ+z6N7XwJ5qK4kBRw07dx2qWSxBiOjfaQ6f1CKVUq7mTaX41tMKeuEFvYWgj9f6BFy+XmHSbDmruo/3KCFRGTUNeN5MhrbjaYOnNBAW/eFbY8q4ZlhTjm/6XXXwJ/NEA4/j4778pTdVokpaE3Aa3MbLfpsKMGDCN7AzkGpDnFHduXTfTeroyRcQaT8ZF6LWolg1actd69Hlq4i2qYWyoSHQoO1eQV95bZiMaOq/dclC35xI+miLGahmsm2ZgwcrpylPQ6OuRVUekPNwoDdVZxsiXK64jRo7KfoYXGNiiwXoenxcF8LQjbd5pn9VC5pxRBxtu4kj37a98yH1Y2P7Nr2GrxcKUGj6Dz1UiBSTmAQf5ogIiyuLT60xeS7333TDSP9cFt63ePPe3pojY7aA47O3XpJP4IGDUKm63ijA75C45mRXtiWCMGIfSmwlBnwXNBypJILAGuyppuAe+Wtyys3va3faDp2HAJ75ebWd4TBHR0nal0QH3zQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e047839f-3e85-415d-73d5-08d9b0b022c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4642.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 07:41:19.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2468
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Nov 2021 07:41:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13112



On 26.11.21 06:18, Tim Orling wrote:
> In places like sanity.bbclass we currently use
> distutils.version.LooseVersion, but distutils is deprecated in Python
> 3.10 and will be removed in Python 3.12 (~October 2023).
> 
> The recommended replacement for for distutils.version.LooseVersion is
> packaging.version.Version, but this implies 'packaging' be installed on
> the host. It is also not the same functionality as LooseVersion.
> 
> [YOCTO #14610]
> 
> Signed-off-by: Tim Orling <timothy.t.orling@intel.com>
> ---
>   lib/bb/version.py | 347 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 347 insertions(+)
>   create mode 100644 lib/bb/version.py
> 
> diff --git a/lib/bb/version.py b/lib/bb/version.py
> new file mode 100644
> index 00000000..510582b5
> --- /dev/null
> +++ b/lib/bb/version.py
> @@ -0,0 +1,347 @@
> +#
> +# distutils/version.py
> +#
> +# Implements multiple version numbering conventions for the
> +# Python Module Distribution Utilities.
> +#
> +# SPDX-License-Identifier: PSF-2.0

If we now ship PSF licensed code, it might be worth mentioning that as 
an external component in LICENSE in the root dir

> +#
> +
> +"""Provides classes to represent module version numbers (one class for
> +each style of version numbering).  There are currently two such classes
> +implemented: StrictVersion and LooseVersion.
> +
> +Every version number class implements the following interface:
> +  * the 'parse' method takes a string and parses it to some internal
> +    representation; if the string is an invalid version number,
> +    'parse' raises a ValueError exception
> +  * the class constructor takes an optional string argument which,
> +    if supplied, is passed to 'parse'
> +  * __str__ reconstructs the string that was passed to 'parse' (or
> +    an equivalent string -- ie. one that will generate an equivalent
> +    version number instance)
> +  * __repr__ generates Python code to recreate the version number instance
> +  * _cmp compares the current instance with either another instance
> +    of the same class or a string (which will be parsed to an instance
> +    of the same class, thus must follow the same rules)
> +"""
> +
> +import re
> +
> +class Version:
> +    """Abstract base class for version numbering classes.  Just provides
> +    constructor (__init__) and reproducer (__repr__), because those
> +    seem to be the same for all version numbering classes; and route
> +    rich comparisons to _cmp.
> +    """
> +
> +    def __init__ (self, vstring=None):
> +        if vstring:
> +            self.parse(vstring)
> +
> +    def __repr__ (self):
> +        return "%s ('%s')" % (self.__class__.__name__, str(self))
> +
> +    def __eq__(self, other):
> +        c = self._cmp(other)
> +        if c is NotImplemented:
> +            return c
> +        return c == 0
> +
> +    def __lt__(self, other):
> +        c = self._cmp(other)
> +        if c is NotImplemented:
> +            return c
> +        return c < 0
> +
> +    def __le__(self, other):
> +        c = self._cmp(other)
> +        if c is NotImplemented:
> +            return c
> +        return c <= 0
> +
> +    def __gt__(self, other):
> +        c = self._cmp(other)
> +        if c is NotImplemented:
> +            return c
> +        return c > 0
> +
> +    def __ge__(self, other):
> +        c = self._cmp(other)
> +        if c is NotImplemented:
> +            return c
> +        return c >= 0
> +
> +
> +# Interface for version-number classes -- must be implemented
> +# by the following classes (the concrete ones -- Version should
> +# be treated as an abstract class).
> +#    __init__ (string) - create and take same action as 'parse'
> +#                        (string parameter is optional)
> +#    parse (string)    - convert a string representation to whatever
> +#                        internal representation is appropriate for
> +#                        this style of version numbering
> +#    __str__ (self)    - convert back to a string; should be very similar
> +#                        (if not identical to) the string supplied to parse
> +#    __repr__ (self)   - generate Python code to recreate
> +#                        the instance
> +#    _cmp (self, other) - compare two version numbers ('other' may
> +#                        be an unparsed version string, or another
> +#                        instance of your version class)
> +
> +
> +class StrictVersion (Version):
> +
> +    """Version numbering for anal retentives and software idealists.
> +    Implements the standard interface for version number classes as
> +    described above.  A version number consists of two or three
> +    dot-separated numeric components, with an optional "pre-release" tag
> +    on the end.  The pre-release tag consists of the letter 'a' or 'b'
> +    followed by a number.  If the numeric components of two version
> +    numbers are equal, then one with a pre-release tag will always
> +    be deemed earlier (lesser) than one without.
> +
> +    The following are valid version numbers (shown in the order that
> +    would be obtained by sorting according to the supplied cmp function):
> +
> +        0.4       0.4.0  (these two are equivalent)
> +        0.4.1
> +        0.5a1
> +        0.5b3
> +        0.5
> +        0.9.6
> +        1.0
> +        1.0.4a3
> +        1.0.4b1
> +        1.0.4
> +
> +    The following are examples of invalid version numbers:
> +
> +        1
> +        2.7.2.2
> +        1.3.a4
> +        1.3pl1
> +        1.3c4
> +
> +    The rationale for this version numbering system will be explained
> +    in the distutils documentation.
> +    """
> +
> +    version_re = re.compile(r'^(\d+) \. (\d+) (\. (\d+))? ([ab](\d+))?$',
> +                            re.VERBOSE | re.ASCII)
> +
> +
> +    def parse (self, vstring):
> +        match = self.version_re.match(vstring)
> +        if not match:
> +            raise ValueError("invalid version number '%s'" % vstring)
> +
> +        (major, minor, patch, prerelease, prerelease_num) = \
> +            match.group(1, 2, 4, 5, 6)
> +
> +        if patch:
> +            self.version = tuple(map(int, [major, minor, patch]))
> +        else:
> +            self.version = tuple(map(int, [major, minor])) + (0,)
> +
> +        if prerelease:
> +            self.prerelease = (prerelease[0], int(prerelease_num))
> +        else:
> +            self.prerelease = None
> +
> +
> +    def __str__ (self):
> +
> +        if self.version[2] == 0:
> +            vstring = '.'.join(map(str, self.version[0:2]))
> +        else:
> +            vstring = '.'.join(map(str, self.version))
> +
> +        if self.prerelease:
> +            vstring = vstring + self.prerelease[0] + str(self.prerelease[1])
> +
> +        return vstring
> +
> +
> +    def _cmp (self, other):
> +        if isinstance(other, str):
> +            other = StrictVersion(other)
> +        elif not isinstance(other, StrictVersion):
> +            return NotImplemented
> +
> +        if self.version != other.version:
> +            # numeric versions don't match
> +            # prerelease stuff doesn't matter
> +            if self.version < other.version:
> +                return -1
> +            else:
> +                return 1
> +
> +        # have to compare prerelease
> +        # case 1: neither has prerelease; they're equal
> +        # case 2: self has prerelease, other doesn't; other is greater
> +        # case 3: self doesn't have prerelease, other does: self is greater
> +        # case 4: both have prerelease: must compare them!
> +
> +        if (not self.prerelease and not other.prerelease):
> +            return 0
> +        elif (self.prerelease and not other.prerelease):
> +            return -1
> +        elif (not self.prerelease and other.prerelease):
> +            return 1
> +        elif (self.prerelease and other.prerelease):
> +            if self.prerelease == other.prerelease:
> +                return 0
> +            elif self.prerelease < other.prerelease:
> +                return -1
> +            else:
> +                return 1
> +        else:
> +            assert False, "never get here"
> +
> +# end class StrictVersion
> +
> +
> +# The rules according to Greg Stein:
> +# 1) a version number has 1 or more numbers separated by a period or by
> +#    sequences of letters. If only periods, then these are compared
> +#    left-to-right to determine an ordering.
> +# 2) sequences of letters are part of the tuple for comparison and are
> +#    compared lexicographically
> +# 3) recognize the numeric components may have leading zeroes
> +#
> +# The LooseVersion class below implements these rules: a version number
> +# string is split up into a tuple of integer and string components, and
> +# comparison is a simple tuple comparison.  This means that version
> +# numbers behave in a predictable and obvious way, but a way that might
> +# not necessarily be how people *want* version numbers to behave.  There
> +# wouldn't be a problem if people could stick to purely numeric version
> +# numbers: just split on period and compare the numbers as tuples.
> +# However, people insist on putting letters into their version numbers;
> +# the most common purpose seems to be:
> +#   - indicating a "pre-release" version
> +#     ('alpha', 'beta', 'a', 'b', 'pre', 'p')
> +#   - indicating a post-release patch ('p', 'pl', 'patch')
> +# but of course this can't cover all version number schemes, and there's
> +# no way to know what a programmer means without asking him.
> +#
> +# The problem is what to do with letters (and other non-numeric
> +# characters) in a version number.  The current implementation does the
> +# obvious and predictable thing: keep them as strings and compare
> +# lexically within a tuple comparison.  This has the desired effect if
> +# an appended letter sequence implies something "post-release":
> +# eg. "0.99" < "0.99pl14" < "1.0", and "5.001" < "5.001m" < "5.002".
> +#
> +# However, if letters in a version number imply a pre-release version,
> +# the "obvious" thing isn't correct.  Eg. you would expect that
> +# "1.5.1" < "1.5.2a2" < "1.5.2", but under the tuple/lexical comparison
> +# implemented here, this just isn't so.
> +#
> +# Two possible solutions come to mind.  The first is to tie the
> +# comparison algorithm to a particular set of semantic rules, as has
> +# been done in the StrictVersion class above.  This works great as long
> +# as everyone can go along with bondage and discipline.  Hopefully a
> +# (large) subset of Python module programmers will agree that the
> +# particular flavour of bondage and discipline provided by StrictVersion
> +# provides enough benefit to be worth using, and will submit their
> +# version numbering scheme to its domination.  The free-thinking
> +# anarchists in the lot will never give in, though, and something needs
> +# to be done to accommodate them.
> +#
> +# Perhaps a "moderately strict" version class could be implemented that
> +# lets almost anything slide (syntactically), and makes some heuristic
> +# assumptions about non-digits in version number strings.  This could
> +# sink into special-case-hell, though; if I was as talented and
> +# idiosyncratic as Larry Wall, I'd go ahead and implement a class that
> +# somehow knows that "1.2.1" < "1.2.2a2" < "1.2.2" < "1.2.2pl3", and is
> +# just as happy dealing with things like "2g6" and "1.13++".  I don't
> +# think I'm smart enough to do it right though.
> +#
> +# In any case, I've coded the test suite for this module (see
> +# ../test/test_version.py) specifically to fail on things like comparing
> +# "1.2a2" and "1.2".  That's not because the *code* is doing anything
> +# wrong, it's because the simple, obvious design doesn't match my
> +# complicated, hairy expectations for real-world version numbers.  It
> +# would be a snap to fix the test suite to say, "Yep, LooseVersion does
> +# the Right Thing" (ie. the code matches the conception).  But I'd rather
> +# have a conception that matches common notions about version numbers.
> +
> +class LooseVersion (Version):
> +
> +    """Version numbering for anarchists and software realists.
> +    Implements the standard interface for version number classes as
> +    described above.  A version number consists of a series of numbers,
> +    separated by either periods or strings of letters.  When comparing
> +    version numbers, the numeric components will be compared
> +    numerically, and the alphabetic components lexically.  The following
> +    are all valid version numbers, in no particular order:
> +
> +        1.5.1
> +        1.5.2b2
> +        161
> +        3.10a
> +        8.02
> +        3.4j
> +        1996.07.12
> +        3.2.pl0
> +        3.1.1.6
> +        2g6
> +        11g
> +        0.960923
> +        2.2beta29
> +        1.13++
> +        5.5.kw
> +        2.0b1pl0
> +
> +    In fact, there is no such thing as an invalid version number under
> +    this scheme; the rules for comparison are simple and predictable,
> +    but may not always give the results you want (for some definition
> +    of "want").
> +    """
> +
> +    component_re = re.compile(r'(\d+ | [a-z]+ | \.)', re.VERBOSE)
> +
> +    def __init__ (self, vstring=None):
> +        if vstring:
> +            self.parse(vstring)
> +
> +
> +    def parse (self, vstring):
> +        # I've given up on thinking I can reconstruct the version string
> +        # from the parsed tuple -- so I just store the string here for
> +        # use by __str__
> +        self.vstring = vstring
> +        components = [x for x in self.component_re.split(vstring)
> +                              if x and x != '.']
> +        for i, obj in enumerate(components):
> +            try:
> +                components[i] = int(obj)
> +            except ValueError:
> +                pass
> +
> +        self.version = components
> +
> +
> +    def __str__ (self):
> +        return self.vstring
> +
> +
> +    def __repr__ (self):
> +        return "LooseVersion ('%s')" % str(self)
> +
> +
> +    def _cmp (self, other):
> +        if isinstance(other, str):
> +            other = LooseVersion(other)
> +        elif not isinstance(other, LooseVersion):
> +            return NotImplemented
> +
> +        if self.version == other.version:
> +            return 0
> +        if self.version < other.version:
> +            return -1
> +        if self.version > other.version:
> +            return 1
> +
> +
> +# end class LooseVersion
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13111): https://lists.openembedded.org/g/bitbake-devel/message/13111
> Mute This Topic: https://lists.openembedded.org/mt/87314237/3647476
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kweihmann@outlook.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


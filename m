Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26CBC433F5
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 17:18:21 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.27])
 by mx.groups.io with SMTP id smtpd.web08.187.1635268701262194656
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 10:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com
 header.s=selector1 header.b=Si8qiacH;
 spf=pass (domain: outlook.com, ip: 40.92.89.27,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2bW6/b1V4OIK8e8CcxNBgBtlBXsiTslNdoLMbwu/yiBpbI+KZTBaVQgTmU+iPVNa6/XXuz3meox6Nj9vAfzZQVr7RDxuLl//vnWCY7fP4S9lNXYsZl9vSpV8qsZSIi7HLRJr/6QUsklgp7LvG5l4DQjidFDY+fzcbXl7VMqFOEycTfq1uHc1z82wPk4t+H4RhR7MLFRw3zYhz4YDiP6PALXWRuoZoQdIfqUXNvz8fd7d2PZfoeB7/+Kc8WULBkFyv7U+1IWG/1Une4mu8UUXvK2xB2zi3gUQUjB0joydA6nw9ohn26cJEHlbytMlrW3eMiuYMmgt2UepvLMdLum/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k567qm/4oA5OMiNZKPMaFUfYgPCk7RtjTryK0AjR/N8=;
 b=bnbFqSj99AWdMgn8LhFxP3PkbcFCbkol+LFU6DqP2VGxNe+53dakdID5oaZqxv+rTKgWvcitjyulww81XFteW0xkQeim3JfYPrv6nrbVCHcBo6juzbmqHUPBSVhzYdt50ZzLsdE40bxZfb8m6fN1xRMj3qKsCwx9Oom0n1suauL04QPG9FwSa8e13gPL12s4uYqTpjq3wmp7tSLYA9RhJKBMpDvQuyMfwaOQ+EdbWv1S+lH5BJf4ux8ASI1m/ODw2IU/YRFHIhmfu8TMK/mNmK6b+ko3YCe/d+c89E6r2NiDBZdFMZmVq1dWphlW4uz5fEd+QFmR7oxaaAWKBcJIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k567qm/4oA5OMiNZKPMaFUfYgPCk7RtjTryK0AjR/N8=;
 b=Si8qiacHIn2jKBdsLRPU8Qya2wxu1feo88RPxzB73IvQ70jcKbFC9hFweRa+yePYV4f9CIdmaEeBv5yMMVYaqA2ZxNPiDizpCSxwifxcNKBJs4gtY7vHuNQfdZwLmKdrq/2uhd9CYFlBiHxELNfwpQS94VF3fKK0FEXhLItYe3YGuT5FtwoOIaYJ5pwYqKiob43+yWAMowsTmlIF3xike+6ETLPuuZzvzmq0syg33gM23KNC7mYDOwmYjSMg8F0mC0jEoRcwDD9/bqyjoUC9EwJu2dDDLknIwV0zyw2CoQT9iuGFx4K0YenpGt2aHOA3CY0MxUAz3shNZq5dTeIAOQ==
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
 by AM0PR09MB3667.eurprd09.prod.outlook.com (2603:10a6:208:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 17:18:19 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 17:18:19 +0000
Subject: Re: [bitbake-devel] noexec varflag behavior vs documentation?
To: Scott Murray <scott.murray@konsulko.com>,
 bitbake-devel@lists.openembedded.org
References: <d248a56-a985-952c-363c-7a642761c2b6@spiteful.org>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB4642DA41A9B3F3FCF6CB23EDA8849@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Tue, 26 Oct 2021 19:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <d248a56-a985-952c-363c-7a642761c2b6@spiteful.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-TMN: [MEO4Lp5hY3MGSYYfaMK3OAXndaF3LdkfV1PetpyIL9EJrT7usPbulHBVajNNz8O/]
X-ClientProxiedBy: AM3PR05CA0117.eurprd05.prod.outlook.com
 (2603:10a6:207:2::19) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
X-Microsoft-Original-Message-ID: 
 <20c3e6c0-ee2b-d309-83d0-7f4fb02cb606@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 AM3PR05CA0117.eurprd05.prod.outlook.com (2603:10a6:207:2::19) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 17:18:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1965879c-c9a2-4f15-a915-08d998a49ad4
X-MS-TrafficTypeDiagnostic: AM0PR09MB3667:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	es9nq4zyTqP2qOoGrpq+yvMQiu0WL6uLMjW2snmhXfiSUhJwVQfq5nlnYXyiRrG1jSYZziirbU8iSsjffbF2q+16YkJKmyWXLEWtp2bT/fdTyIu5rgoiKTSp54VIQe3X/vFr69vNjUAnzqdlQRP2QAiXwyM/OCM/WloquZYubI7l5YpHjTj9DhJx6UcG4cOBIx3NgSAfaAIl2jXYGdm6YtI99/JzWoxU1+PWg8EfREdNjd7FI3nuMOZrpCGhJj/9CWO1MktmOqE6thHyPVIcGxJNh91/qpAaHnQL9KNKfblcyjq31ayGWKLe6XpbnQz9jZU4RF+GvlfFhlIRGDR+UR0IFffVOKrv2VBj8jHm3BWkRVXHlm4+ehoDS8IR2ZpT6OxxK0QMsUl+PHkSipGfSnFeB313m137GQLzmhxdMuq/naYa2EvAUqWwnEO4+JuibcQrF/I14PpcCbBDH3we/TKI0EWkzou7GEPfzIWmGb0yqIayyRlti34EOLNbxZ9AURFBiugqW2bvfoheDD7RJqLCqh7HfORyI5XHILgfP3CZCknuEu7YXokmXKcy4CHJdz4/Jy2pf+jYXTU1JCU2Kuxr5AqVLntXQkE7Smg7bhIgNMxuX6xE3HqEYyuazIv5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	y3MuuR8Q+7p4mLdD/uireAGRLYbx1bwWZBwPLz9vtV7M/HcsN4Jr0vYoxnyAR9h3t/8iicGxGo8MEwiQeBthJJV5i5144CdbuEiqhcD+nIW7vI6Vf/P65b0TVdlM9OMskjZC1I/6axjEa6WkdOBYev8V74EkMNjs4JCXdvD+Z390VXMr9nfFplFBiPgwtTzotxx7GwwkRywLhiqUTiCDzUU4XXVW2ynW8OYdHbNNDFtpt0qSFn47jb5f3g2qYvR83z0rJZoG9kQbarTpRwahybOCw7AEdt5rTlxYHF4qx7V8LAdc+/337DY7X3lOTJ8cnf72BS2Io6dgLnteWL2njwOGiPzwcpdcYQWrLt2TUiNs99obUmPSAajrhD+vIoOwGm2CGTizaU9KHXJS0LOn84kLraK9l37Ab8E7a5TwMRxpsv5jUEFKipIH2J7KbMkAj+3Av48DoLPLJB0j3IGpH8heF1ofq5PdeX/pklnF+PAQ+nqjXVwgN9ojBThItEnRii3zMW3brhoNXDtY4zbErVZX6Ts/Hzk7VvoiN63essLw9kismMwCNR8o/jXBX8fMd9OOVr5JDjkHjLfSvDKRHW1AxIfpb4MF50vbdtdboAZcopPs2cqn5Rn67WV9oIlJvyQuwaaGkUHZs4pBMRRpJl/HDhlpiI5lu9O0OaaKRO1WTnRhhEKMrYk5LufdMyKgZaZGi03HPyQCTfe+TZ96esJHUEDukLqUrRB1n3jQ7C0jTOVVzkVkLJHruFMywqfCkdsu69KJBcPVa55g4HPjmA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1965879c-c9a2-4f15-a915-08d998a49ad4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4642.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:18:19.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3667
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Oct 2021 17:18:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12834

On 26.10.21 17:57, Scott Murray wrote:
> As I brought up on the dev call earlier, the task noexec varflag
> documentation says:
>=20
> * [noexec]: When set to =E2=80=9C1=E2=80=9D, marks the task as being empt=
y, with no
> execution required. You can use the [noexec] flag to set up tasks as
> dependency placeholders, or to disable tasks defined elsewhere that are
> not needed in a particular recipe.
>=20
> (from:
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-ma=
nual-metadata.html?highlight=3Dnoexec#variable-flags)
>=20
> However, as I discovered yesterday, the reality is that it being set to
> any value at all disables execution, which Richard mentioned on the dev
> call helps with performance.  The question Richard asked me to bring here
> is whether the documentation should be updated, or if the behavior should
> be changed to match it?  I do not have a strong opinion either way, but
> would like this resolved somehow to avoid others spending time scratching
> their heads like I did for a bit yesterday.

As I stumbled upon the very same, I'd love to see the docu being updated=20
- I mean implicitly it already does that as noexec can be only=20
deactivated by putting no value in it - but both cases should be=20
properly documented IMO

>=20
> Thanks,
>=20
> Scott
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12833): https://lists.openembedded.org/g/bitbake-deve=
l/message/12833
> Mute This Topic: https://lists.openembedded.org/mt/86606339/3647476
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kweihm=
ann@outlook.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


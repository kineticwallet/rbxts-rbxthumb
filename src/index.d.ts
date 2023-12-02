import RbxthumbIndex from "./RbxthumbIndex";

declare function createRbxthumb<T extends keyof RbxthumbIndex>(
	thumbnailType: T,
	thumbnailId: number,
	thumbnailSize: RbxthumbIndex[T],
	isCircular?: boolean,
): string;

export = createRbxthumb;
